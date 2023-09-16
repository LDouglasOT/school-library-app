# frozen_string_literal: true

require_relative "../person"
require_relative "../teacher"  # Require the teacher.rb file containing the Teacher class

RSpec.describe Teacher do
  describe "#initialize" do
    it "creates a Teacher object with the correct attributes" do
      age = 30
      specialization = "Mathematics"
      name = "John Doe"
      parent_permission = true

      teacher = Teacher.new(age, specialization, name: name, parent_permission: parent_permission)

      expect(teacher.age).to eq(age)
      expect(teacher.name).to eq(name)
      expect(teacher.parent_permission).to eq(parent_permission)
      expect(teacher.specialization).to eq(specialization)
    end
  end

  describe "#can_use_services?" do
    it "returns true" do
      teacher = Teacher.new(35, "Science")

      expect(teacher.can_use_services?).to be(true)
    end
  end
end
