# frozen_string_literal: true

require "./decorating" # Include the Nameable and Decorator classes from decorating.rb

# Represents a classroom.
class Classroom
  attr_accessor :label
  attr_reader :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    students << student
    student.assign_classroom(self)
  end
end

# Represents a Student.
class Student < Nameable
  attr_accessor :name

  def initialize(name)
    super()
    @name = name
    @classroom = nil
  end

  def assign_classroom(classroom)
    @classroom = classroom
  end
end

# Represents a Book.
class Book
  attr_accessor :title, :author
  attr_reader :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    rentals << rental
    rental.book = self
  end
end

# Represents a Rental.
class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.add_rental(self) # Establish the relationship between book and rental
    person.rent_book(self) # Establish the relationship between person and rental
  end
end

# Represents a Person.
class Person < Decorator
  attr_accessor :name

  def initialize(name)
    super()
    @name = name
  end

  def rent_book(rental)
    rentals << rental
  end
end

# Block to test the different classes

# Create a classroom
classroom = Classroom.new("Class A")

# Create students
student1 = Student.new("John")
student2 = Student.new("Emily")

# Add students to the classroom
classroom.add_student(student1)
classroom.add_student(student2)

# Check the classroom label and students
puts "Classroom: #{classroom.label}"
puts "Students: #{classroom.students.map(&:name).join(", ")}"

# Create a person
book = Book.new("The Great Gatsby", "F. Scott Fitzgerald")
person = Person.new("John")
# Create a rental between the book and the person
rental = Rental.new("2023-06-29", book, person)
# Accessing the rental's date, book, and person
puts rental.date # Output: 2023-06-29
puts rental.book.inspect # Output: #<Book:0x00007ff4a69531f0 @title="The Great Gatsby", @author="F. Scott Fitzgerald">
puts rental.person.inspect # Output: #<Person:0x00007ff4a6952f80 @name="John">

# Check the person's rentals
puts "Person: #{person.correct_name}" # Use the correct_name method from the decorator
