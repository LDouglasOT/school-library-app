# frozen_string_literal: true

# Represents student
class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.rentals << self
    person.rentals << self
  end

  def self.save_rentals(filename, data = [], _people)
    rental_store = []
    data.each do |rentals|
      rental_store << { date: rentals.date, book: rentals.book, person: rentals.person }
    end
    puts rental_store
    File.write(filename, JSON.generate(rental_store))
  end
end
