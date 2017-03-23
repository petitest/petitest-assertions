require "petitest/autorun"
require "petitest/assertions"

class PetitestTest < Petitest::TestGroup
  include ::Petitest::Assertions

  def test_assert_equal
    assert_equal(2, 1 + 1)
  end

  def test_assert_match
    assert_match(/oo/, "foo")
  end

  def test_assert_operator
    assert_operator(2, :>=, 2)
  end

  def test_assert_output_about_stdout
    assert_output(/bar/, nil) do
      puts "foo"
      puts "bar"
    end
  end

  def test_assert_output_about_stderr
    assert_output(nil, /bar/) do
      $stdout.puts "foo"
      $stdout.puts "bar"
    end
  end

  def test_assert_output_about_stdout_and_stderr
    assert_output(/foo/, /bar/) do
      puts "foo"
      $stdout.puts "bar"
    end
  end

  def test_assert_raise
    assert_raise(::StandardError) do
      raise
    end
  end

  def test_assert_to_be
    assert_to_be(:empty, [])
  end

  def test_assert_to_have
    assert_to_have(:key, :foo, foo: :bar)
  end
end
