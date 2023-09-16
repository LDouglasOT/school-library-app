require_relative 'nameable'
require_relative 'rental'

# Represents Person
class Person < Nameable
  attr_accessor :name, :age, :parent_permission, :rentals

  def initialize(age, name: 'Unknown', parent_permission: true)
    super()
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end

  def generate_id
    rand(1..1000)
  end

  private_class_method def self.write_file(filename, data = [])
    person_store = []
    data.each do |d|
      person_store << if d.instance_of?(Student)
                        { type: 'student', id: d.id, age: d.age, name: d.name, parent_permission: d.parent_permission }
                      else
                        { type: 'teacher', id: d.id, age: d.age, name: d.name, specialization: d.specialization }
                      end
    end
    File.write(filename, JSON.generate(person_store))
  end
end
