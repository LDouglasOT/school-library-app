# Import necessary dependencies
require_relative 'trim'  # Require the trim.rb file containing TrimmerDecorator

# Create a test class for TrimmerDecorator
RSpec.describe TrimmerDecorator do
  describe '#correct_name' do
    it 'trims the name to the maximum length' do
      # Create a nameable object with a long name
      nameable = Nameable.new
      long_name = 'This is a very long name'
      nameable.instance_variable_set(:@name, long_name)

      # Create a trimmer decorator
      trimmer = TrimmerDecorator.new(nameable)

      # Ensure the name is trimmed to the maximum length
      expect(trimmer.correct_name).to eq(long_name[0...TrimmerDecorator::MAX_LENGTH])
    end

    it 'returns the original name if it is shorter' do
      # Create a nameable object with a short name
      nameable = Nameable.new
      short_name = 'ShortName'
      nameable.instance_variable_set(:@name, short_name)

      # Create a trimmer decorator
      trimmer = TrimmerDecorator.new(nameable)

      # Ensure the name is returned as is
      expect(trimmer.correct_name).to eq(short_name)
    end
  end
end
