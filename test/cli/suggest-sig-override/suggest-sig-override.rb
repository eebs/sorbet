# typed: strict

extend T::Helpers

# Suggest "implementation." for these classes
module Abstract
  extend T::Helpers
  abstract!
  sig {abstract.void}
  def foo; end
end
class Implementation
  include Abstract

  def foo; end
end

# Suggest "override." for these classes
class Parent
  extend T::Helpers
  sig {void}
  def initialize; end

  sig {overridable.void}
  def foo; end

  sig {void}
  def bar; end

  def qux; end
end
class Child < Parent
  def initialize; end

  def foo; end

  def bar; end

  def qux; end
end

# Weird overridable edge cases in string parsing
class Parent
  extend T::Helpers

  sig {void}
  def just_void; end

  sig {returns(NilClass)}
  def just_returns; end

  sig {params(x: Integer).void}
  def x_to_void(x); end

  sig {params(x: Integer).returns(NilClass)}
  def x_to_returns(x); end

  sig do
    params(x: Integer)
    .void
  end
  def multiline_x_to_void(x); end

  sig do
    params(x: Integer)
    .returns(NilClass)
  end
  def multiline_x_to_returns(x); end
end
class Child < Parent
  def just_void; end

  def just_returns; end

  def x_to_void(x); end

  def x_to_returns(x); end

  def multiline_x_to_void(x); end

  def multiline_x_to_returns(x); end
end