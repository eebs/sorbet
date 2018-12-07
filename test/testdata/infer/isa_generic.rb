# typed: true
extend T::Helpers

class Base
  extend T::Generic
  Klass = type_template
end

class Concrete < Base
  Klass = type_template(fixed: String)
end

class Other
end

sig { params(x: T.any(Concrete, Other)).void }
def f(x)
  case x
  when Concrete
    T.assert_type!(x, Concrete)
  when Other
    T.assert_type!(x, Other)
  end

  # Test both `===` and `is_a?`
  if x.is_a?(Concrete)
    T.assert_type!(x, Concrete)
  end

  unless x.is_a?(Other)
    T.assert_type!(x, Concrete)
  end
end
