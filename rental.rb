# frozen_string_literal: true

# Defines a Rental class
class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date:, book:, person:)
    @date = date
    @book = book
    @person = person
  end

  def person=(person)
    @person = person
    person.rentals.push(self) unless person.rentals.include?(self)
  end

  def book=(book)
    @book = book
    book.rentals.push(self) unless book.rentals.include?(self)
  end

  def to_h
    {
      date: date,
      book: book.to_h,
      person: person.to_h
    }
  end
end
