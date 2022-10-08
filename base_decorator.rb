# frozen_string_literal: true

require_relative 'nameable'

# Defines a base_decorator class
class BaseDecorator < Nameable
  def initialize(nameable)
    super
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end
