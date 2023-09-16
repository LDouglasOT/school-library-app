# rubocop:disable all

# frozen_string_literal: true

# spec/book_spec.rb

require_relative "../book" # Adjust the path as needed
require "json"
RSpec.describe Book do
  describe "#initialize" do
    it "creates a new book with title and author" do
      book = Book.new("Title", "Author")
      expect(book.title).to eq("Title")
      expect(book.author).to eq("Author")
    end
  end

  describe "#to_s" do
    it "returns a formatted string" do
      book = Book.new("Title", "Author")
      expect(book.to_s).to eq("Title: Title, Author: Author")
    end
  end

  describe ".save_book" do
    it "saves book data to a JSON file" do
      # Create some sample books
      books = [
        Book.new("Book1", "Author1"),
        Book.new("Book2", "Author2")
      ]

      # Define the expected JSON data
      expected_data = [
        { title: "Book1", author: "Author1" },
        { title: "Book2", author: "Author2" }
      ]

      # Use a temporary test file
      test_filename = "test_books.json"

      # Expect the File.write method to be called with the expected data
      expect(File).to receive(:write).with(test_filename, JSON.generate(expected_data))

      # Call the .save_book method to save the data
      Book.save_book(test_filename, books)
    end
  end
end
