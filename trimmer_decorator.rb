require_relative 'base_decorator'

# Defines a trimmer_decorator class
class TrimmerDecorator < BaseDecorator
  def correct_name
    name = @nameable.correct_name

    if name.length > 10
      name[0...10]
    else
      name
    end
  end
end
