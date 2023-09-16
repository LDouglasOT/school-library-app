# spec/nameable_spec.rb

require_relative '../nameable'

RSpec.describe Nameable do
  describe '#correct_name' do
    it 'raises a NotImplementedError with the correct message' do
      nameable = Nameable.new
      expect { nameable.correct_name }.to raise_error(NotImplementedError, "Method not implemented")
    end
  end
end
