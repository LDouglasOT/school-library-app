# frozen_string_literal: true

require_relative "../classroom"

RSpec.describe Classroom do
  describe "#initialize" do
    it "creates a new Classroom object with a label" do
      classroom = Classroom.new("Room 101")
      expect(classroom.label).to eq("Room 101")
    end
  end

  describe "#add_student" do
    it "adds a student to the classroom" do
      classroom = Classroom.new("Room 101")
      student = double("Student")

      # Stub the student's classroom= method to avoid unexpected messages
      allow(student).to receive(:classroom=)

      classroom.add_student(student)

      # Check the length of the students array
      expect(classroom.students.length).to eq(1)

      # Verify that the student's classroom= method was called with the current classroom
      expect(student).to have_received(:classroom=).with(classroom)
    end
  end
end
