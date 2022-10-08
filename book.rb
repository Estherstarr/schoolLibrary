# frozen_string_literal: true

# Defines a Book class
class Book
  attr_accessor :title, :author
  attr_reader :rentals

  def initialize(title:, author:)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
    rental.book = self
  end

  def to_h
    {
      title: title,
      author: author
    }
  end
end
