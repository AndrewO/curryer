# Curryer

The Delegator that curries!

There are often times where you have a module or class with many methods that
share the same initial arguments and you'd like to just set them once. Curryer
provides a method that allows you to generate an object that saves those first
couple arguments as its own state, while exposing the target's methods (with a
lower arity).

In functional programming, this is called "currying" or "partial evaluation".
Ruby supports this on the Proc level with Proc#curry. Currying is an important
concept and indeed serves as the theoretical basis for how computation works.
In fact, object-oriented programming is actually nothing by the combination of
structures/records/tuples and partially evaluated functions (see the second
example in lib/curryer if you don't believe me).

## Running tests

This library uses Ruby-Doctest. After running `bundle install`, you can run
tests using `bundle exec rubydoctest lib/*.rb`.

## Installation

Add this line to your application's Gemfile:

    gem 'curryer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install curryer

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
