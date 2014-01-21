require "curryer/version"
require "delegate"

module Curryer
  # @param target [Object] Object whose methods will be wrapped in curried.
  #   versions
  # @param *args [Array] The first n arguments of every wrapped method.
  # @returns Curried A delegator with a set of arguments that will be used in
  #   every method call to its delegate.
  #
  #  doctest_require: "../doctest_helper"
  #  doctest: Wrap an instantiated object.
  #  >> foo = Foo.new
  #  >> curried = Curryer.for_all(foo, 1, 2)
  #  >> curried.do_stuff(3)
  #  => 0
  #  >> curried.do_stuff(1)
  #  => 2
  #
  #  doctest: Wrap a module with state.
  #  >> person = Curryer.for_all(FakeOOP, "Andrew", "O'Brien")
  #  >> person.full_name
  #  => "Andrew O'Brien"
  #
  #  doctest: Raises ArgumentError when too many things are passed in.
  #  >> person = Curryer.for_all(FakeOOP, "Andrew", "O'Brien")
  #  >> begin; person.full_name("Jr."); rescue => e; end
  #  >> e.class
  #  => ArgumentError
  #
  #   Look, ma! Object Oriented Programming is just degenerate Functional
  #   Programming!
  def self.for_all(target, *args)
    Curried.new(target, args)
  end

  # DO NOT USE. Not implemented.
  #
  # If this is actually needed, it opens up all sorts of questions like:
  #
  # 1. Should we have a CurriedClass (like DelegateClass) that defined methods
  #    instead of using method_missing?
  # 2. Should we make a mixin that allows a compile time specification of
  #    currying (think Forwardable instead of Delegate)?
  #
  # These are some interesting routes to go down, are probably pretty easy to
  # implement, and are valid use cases. I just don't have them right now. If
  # you do, let me know.
  def self.for_methods(object, methods, *args)
    raise "Not implemented. Do you actually need this? " +
      "Or should the caller switch between the un-curried object and its curried version?"
  end

  class Curried < Delegator
    def initialize(target, args)
      @target, @args = target, args
      reset_cache!
    end

    def __get_obj__
      @target
    end

    def __set_obj__(new_target)
      reset_cache!
      @target = new_target
    end

    # See STLIB's delegate.rb. This is mostly just an adaption of what the
    # base Delegate#method_missing is doing.
    def method_missing(m, *local_args, &b)
      target = self.__get_obj__

      # Get the method, and put a partially-evaluated version of it in the cache
      # so that we don't have to re-curry future calls. Then call it with the
      # local args.
      if target.respond_to?(m)
        result = @cache[m] ||= target.method(m).to_proc.curry[*@args]
        if local_args.empty?
          result
        else
          if result.respond_to?(:call)
            result.call(*local_args)
          else
            raise ArgumentError, \
              "Curried result #{result.inspect} is not callable but arguments #{local_args} were still given. " +
              "You're trying to call the method with more arguments than it takes."
          end
        end
      else
        super(m, *local_args, &b)
      end
    end

    private
    def reset_cache!
      @cache = {}
    end
  end
end
