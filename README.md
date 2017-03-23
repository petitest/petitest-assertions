# Petitest::Assertions

[![Gem Version](https://badge.fury.io/rb/petitest-assertions.svg)](https://rubygems.org/gems/petitest-assertions)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/github/petitest/petitest-assertions)

Assertions for [Petitest](https://github.com/petitest/petitest-assertions).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "petitest-assertions"
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install petitest-assertions
```

## Usage

### Setup

Include `Petitest::Assertions`:

```ruby
require "petitest/assertions"

class PetitestTest < Petitest::TestGroup
  include ::Petitest::Assertions

  # ... your tests ...
end
```

### assert_equal

```ruby
assert_equal(2, 1 + 1)
```

### assert_match

```ruby
assert_match(/foo/, "fooooo")
```

### assert_operator

```ruby
assert_operator(2, :>, 1)
```

### assert_output

```ruby
assert_output(/foo/, nil) do
  puts "fooooo"
end
```

### assert_output

```ruby
assert_output(nil, /foo/) do
  $stdout.puts "fooooo"
end
```

### assert_output

```ruby
assert_output(/foo/, /bar/) do
  puts "fooooo"
  $stdout.puts "barrrr"
end
```

### assert_raise

```ruby
assert_raise(::StandardError) do
  raise
end
```

### assert_to_be

```ruby
assert_to_be(:empty, [])
```

### assert_to_have

```ruby
assert_to_have(:key, :foo, foo: :bar)
```
