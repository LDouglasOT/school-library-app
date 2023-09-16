# rubocop:disable all
# frozen_string_literal: true

require_relative "person"
require_relative "classroom"
require_relative "book"
require_relative "rental"
require_relative "student"
require_relative "teacher"
require 'json'

class App
  attr_reader :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
    read_files
    read_people
    at_exit { datasaver }
  end
  
  def read_people
      JSON.parse(File.read("person.json")).each do |element|
        if element['type'] == 'student'
          @people << Student.new(element['age'], name: element['name'],parent_permission: element['parent_permission'])
        else
          @people << Teacher.new(element['age'], element['specialization'], name: element['name'])
        end
      end
    end
  def read_files
        books = File.read("books.json")
        person = File.read("person.json")
        rentals = File.read("rentals.json")

        parsed_book = JSON.parse(books)
        parsed_person = JSON.parse(person)
        parsed_rentals = JSON.parse(rentals)

        parsed_book.each do |element|
          book = Book.new(element['title'], element['author'])
          @books << book
        end

        # parsed_person.each do |element|
        #   person = Person.new(element['id'], element['name'],element['age'], element['parent_permission'])
        #   @people << person
        # end

        parsed_rentals.each do |element|
          rentals = Rental.new(element['date'], element['book'],element['person'])
          @rentals << rentals
        end
  end
  
  def save_person(filename,data=[])
    person_store = []
    data.each do |persons|
      console.log(persons)
      person_store << { id: persons.id, name: persons.name, age: persons.age,parent_permission: persons.parent_permission,rentals:persons.rentals}
    end
    puts person_store
    File.write(filename, JSON.generate(person_store))
  end

  def list_books
    puts "Listing all books:"
    puts @books
    @books.each do |book|
      puts book
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    puts "Listing all people:"
    @people.each do |person|
      person_type = person.is_a?(Student) ? "Student" : "Teacher"
      puts "[#{person_type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def list_people_with_numbers
    puts "Listing all people:"
    @people.each_with_index do |person, index|
      person_type = person.is_a?(Student) ? "Student" : "Teacher"
      puts "#{index + 1}. #{person_type}: #{person.name}"
    end
  end

  def create_person(type, name = nil, age = nil, parent_permission = nil)
    case type
    when "student"
      name = prompt_name(name)
      age = prompt_age(age)
      parent_permission = prompt_parent_permission(parent_permission)

      @people << Student.new(age, name: name, parent_permission: parent_permission)
    when "teacher"
      age = prompt_age(age)
      name = prompt_name(name)
      specialization = prompt_specialization

      teacher = Teacher.new(age, specialization, name: name)
      @people << teacher
      puts "Teacher successfully created."
    else
      puts "Invalid person type."
    end
  end

  def create_book
    puts "Creating a book:"
    print "Enter title: "
    title = gets.chomp
    print "Enter author: "
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
  end

  def create_rental
    puts "Creating a rental:"

    display_books

    print "Select a book by number: "
    book_number = gets.chomp.to_i

    if valid_book_number?(book_number)
      book = @books[book_number - 1]

      display_people

      print "Select a person by number: "
      person_number = gets.chomp.to_i

      if valid_person_number?(person_number)
        person = @people[person_number - 1]

        create_rental_with_date(book, person)
      else
        puts "Invalid person number."
      end
    else
      puts "Invalid book number."
    end
  end

  def list_rentals_for_person(person_id)
    person = find_person(person_id)

    if person
      puts "Listing rentals for person with ID #{person_id}:"
      rentals = @rentals.select { |r| r.person == person }
      rentals.each do |rental|
        puts "Date: #{rental.date}, Book: #{rental.book.title}, Author: #{rental.book.author}"
      end
    else
      puts "Person not found."
    end
  end

  private

    # Load data from a JSON file into the provided data array
    def load_data(filename, data)
      if File.exist?(filename)
        begin
          json_data = File.read(filename)
          loaded_data = JSON.parse(json_data)
          data.replace(loaded_data) if loaded_data.is_a?(Array)
        rescue JSON::ParserError => e
          puts "Error parsing JSON data from #{filename}: #{e.message}"
        end
      end
    end
    
    def datasaver()
      Book.save_book("books.json", @books)
      Rental.save_rentals("rentals.json", @rentals)
      Person.write_file("person.json", @people)
    end
  
    # Save data to a JSON file
  
  def prompt_name(name)
    return name unless name.nil?

    print "Enter name: "
    gets.chomp
  end

  def prompt_age(age)
    return age unless age.nil?

    print "Enter age: "
    gets.chomp.to_i
  end

  def prompt_parent_permission(permission)
    return permission unless permission.nil?

    print "Has parent permission? [Y/N]: "
    gets.chomp.upcase == "Y"
  end

  def prompt_specialization
    print "Enter specialization: "
    gets.chomp
  end

  def display_books
    puts "List of books:"
    @books.each_with_index do |book, index|
      puts "#{index + 1}. Title: #{book.title}, Author: #{book.author}"
    end
  end

  def valid_book_number?(number)
    number.between?(1, @books.length)
  end

  def display_people
    puts "List of people:"
    list_people_with_numbers
  end

  def valid_person_number?(number)
    number.between?(1, @people.length)
  end

  def find_person(person_id)
    @people.find { |p| p.id == person_id }
  end

  def create_rental_with_date(book, person)
    print "Enter date: "
    date = gets.chomp

    rental = Rental.new(date, book, person)
    @rentals << rental
    puts "Rental created successfully."
  end
end

