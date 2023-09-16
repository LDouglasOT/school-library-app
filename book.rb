# frozen_string_literal: true

# Represents book
class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    Rental.new(date, self, person)
  end

  def to_s
    "Title: #{@title}, Author: #{@author}"
  end

  def self.save_book(filename, data = [])
    book_store = []
    data.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
      book_store << { title: book.title, author: book.author }
    end
    puts book_store
    File.write(filename, JSON.generate(book_store))
  end
end
