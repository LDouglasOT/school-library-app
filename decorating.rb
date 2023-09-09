# frozen_string_literal: true

# Represents a nameable entity.
class Nameable
  def correct_name
    raise NotImplementedError
  end
end

# Represents a decorator for a Nameable object.
class Decorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

# Represents a decorator that capitalizes the output of a Nameable object's correct_name method.
class CapitalizeDecorator < Decorator
  def correct_name
    super.capitalize
  end
end

# Represents a decorator that trims the output of a Nameable object's correct_name method to a maximum of 10 characters.
class TrimmerDecorator < Decorator
  def correct_name
    super[0..9]
  end
end
