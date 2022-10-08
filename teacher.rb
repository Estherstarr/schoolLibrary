# frozen_string_literal: true

require_relative 'person'

# Defines a teacher class
class Teacher < Person
  attr_reader :specialization

  def initialize(age:, specialization:, name: 'Unknown', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_h
    {
      age: age,
      name: name,
      type: 'teacher',
      parent_permission: true
    }
  end
end
