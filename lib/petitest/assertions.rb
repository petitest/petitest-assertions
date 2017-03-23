require "petitest/assertions/version"
require "stringio"

module Petitest
  module Assertions
    # @param expected [#==]
    # @param actual [Object]
    # @param message [String, nil]
    def assert_equal(expected, actual, message = nil)
      message ||= "Expected #{expected.inspect} to be equal to #{actual.inspect}"
      assert(message) do
        expected == actual
      end
    end

    # @param expected [#===]
    # @param actual [Object]
    # @param message [String, nil]
    def assert_match(expected, actual, message = nil)
      message ||= "Expected #{expected.inspect} === #{actual.inspect}"
      assert(message) do
        expected === actual
      end
    end

    # @param left [Object]
    # @param operator [Symbol]
    # @param right [Object]
    def assert_operator(left, operator, right, message = nil)
      message ||= "Expected #{left.inspect} #{operator} #{right.inspect}"
      assert(message) do
        left.__send__(operator, right)
      end
    end

    # @param pattern_for_stdout [#===, nil]
    # @param pattern_for_stderr [#===, nil]
    # @param right [Object]
    def assert_output(pattern_for_stdout, pattern_for_stderr = nil, message = nil, &block)
      output_from_stdout, output_from_stderr = capture_stdout_and_stderr(&block)
      unless pattern_for_stdout.nil?
        assert(message || "Expected stdout output to match with #{pattern_for_stdout.inspect}") do
          pattern_for_stdout === output_from_stdout
        end
      end
      unless pattern_for_stdout.nil?
        assert(message || "Expected stderr output to match with #{pattern_for_stdout.inspect}") do
          pattern_for_stdout === output_from_stdout
        end
      end
    end

    # @param args [Array<Class, String>]
    def assert_raise(*args, &block)
      message = args.pop if args.last.is_a?(::String)
      expected_exception_classes = args
      expected_exception_classes << ::Exception if expected_exception_classes.empty?
      expected_exception_classes_text = expected_exception_classes.map(&:inspect).join(" or ")
      message ||= "Expected #{expected_exception_classes_text} to be raised, but not"
      assert(message) do
        actual = begin
          block.call
          nil
        rescue *expected_exception_classes => exception
          exception
        rescue ::SignalException, ::SystemExit
          raise
        rescue ::Exception => exception
          exception
        end
        expected_exception_classes.any? do |klass|
          klass === actual
        end
      end
    end

    # @param phrase [Symbol]
    # @param args [Array]
    def assert_to_be(phrase, *args)
      actual = args.pop
      method_name = "#{phrase}?"
      args_text = "(#{args.map(&:inspect).join(', ')})" unless args.empty?
      message = "Expected #{actual.inspect}.#{method_name}#{args_text} to be truthy"
      assert(message) do
        actual.__send__(method_name, *args)
      end
    end

    # @param phrase [Symbol]
    # @param args [Array]
    def assert_to_have(phrase, *args)
      actual = args.pop
      method_name = "has_#{phrase}?"
      args_text = "(#{args.map(&:inspect).join(', ')})" unless args.empty?
      message = "Expected #{actual.inspect}.#{method_name}#{args_text} to be truthy"
      assert(message) do
        actual.__send__(method_name, *args)
      end
    end

    private

    # @return [Array<String>]
    def capture_stdout_and_stderr(&block)
      dummy_stdout = ::StringIO.new
      dummy_stderr = ::StringIO.new
      original_stdout = $stdout
      original_stderr = $stderr
      $stdout = dummy_stdout
      $stderr = dummy_stderr
      block.call
      [
        dummy_stdout.string,
        dummy_stderr.string,
      ]
    ensure
      $stdout = original_stdout
      $stderr = original_stderr
    end
  end
end

path = ::File.expand_path("../..", __FILE__)
::Petitest.configuration.backtrace_filters << -> (line) { line.start_with?(path) }
