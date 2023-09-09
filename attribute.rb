# frozen_string_literal: true

# Represents a classroom.
class Classroom
  attr_accessor :label, :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    students << student
    student.classroom = self
  end
end

# Represents a Student.
class Student
  attr_accessor :name, :classroom

  def initialize(name)
    @name = name
    @classroom = nil
  end
end

# Represents a Book.
class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end
end

# Represents a Rental.
class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
  end
end

# Represents a Person.
class Person
  attr_accessor :name, :rentals

  def initialize(name)
    @name = name
    @rentals = []
  end

  def rent_book(book, date)
    rental = Rental.new(date, book, self)
    rentals << rental
    book.rentals << rental
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
puts "Person: #{person.name}"
