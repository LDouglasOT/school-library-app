# frozen_string_literal: true

require_relative "../rental"
require_relative "../book"
require_relative "../person"

RSpec.describe Rental do
  let(:date) { "2023-09-14" }
  let(:book) { Book.new("Sample Book", "Sample Author") }
  let(:person) { Person.new(25, name: "John Doe") }

  describe "#initialize" do
    it "creates a rental with the specified date, book, and person" do
      rental = Rental.new(date, book, person)

      expect(rental.date).to eq(date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end

    it "adds the rental to the book and person" do
      rental = Rental.new(date, book, person)

      expect(book.rentals).to include(rental)
      expect(person.rentals).to include(rental)
    end
  end

  describe ".save_rentals" do
    it "saves rentals data to a file in JSON format" do
      # Stub the file writing process
      allow(File).to receive(:write)

      rentals = [Rental.new(date, book, person)]

      filename = "test_rentals.json"
      Rental.save_rentals(filename, rentals)

      # Expect the File.write method to be called
      expect(File).to have_received(:write).with(filename, anything)

      # You can also check other parts of the code here
    end
  end
end
