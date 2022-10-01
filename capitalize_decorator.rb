require_relative 'base_decorator'

# Defines a capitalize_decorator class
class CapitalizeDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end
