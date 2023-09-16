# frozen_string_literal: true

# spec/person_spec.rb

require_relative "../person"

RSpec.describe Person do
  describe "#initialize" do
    it "creates a person with default values" do
      person = Person.new(20)
      expect(person.name).to eq("Unknown")
      expect(person.age).to eq(20)
      expect(person.parent_permission).to be(true)
      expect(person.rentals).to be_empty
    end
  end

  describe "#can_use_services?" do
    it "returns true if the person is of age" do
      person = Person.new(18)
      expect(person.can_use_services?).to be(true)
    end

    it "returns true if the person has parent permission" do
      person = Person.new(16, parent_permission: true)
      expect(person.can_use_services?).to be(true)
    end

    it "returns false if the person is not of age and has no parent permission" do
      person = Person.new(16, parent_permission: false)
      expect(person.can_use_services?).to be(false)
    end
  end
end
