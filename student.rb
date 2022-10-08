# frozen_string_literal: true

require_relative 'person'

# Defines a student class
class Student < Person
  attr_reader :classroom

  def initialize(age:, classroom:, name: 'Unknown', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def to_h
    {
      age: age,
      name: name,
      type: 'student',
      parent_permission: true
    }
  end
end
