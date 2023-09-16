# frozen_string_literal: true

require_relative "../capitalize"

RSpec.describe CapitalizeDecorator do
  describe "#correct_name" do
    it "capitalizes the name" do
      # Create a mock nameable object with a specific name
      nameable = double("Nameable", correct_name: "john doe")

      # Create a CapitalizeDecorator object with the mock nameable
      capitalize_decorator = CapitalizeDecorator.new(nameable)

      # Call the correct_name method on CapitalizeDecorator
      capitalized_name = capitalize_decorator.correct_name

      # Expect the result to be the capitalized version of the mock name
      expect(capitalized_name).to eq("John Doe")
    end
  end
end
