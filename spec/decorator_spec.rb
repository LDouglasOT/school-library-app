# spec/decorator_spec.rb

require_relative '../decorator'

RSpec.describe Decorator do
  describe '#correct_name' do
    it 'delegates the correct_name method to the wrapped nameable object' do
      mock_nameable = double('Nameable')
      expect(mock_nameable).to receive(:correct_name)
      decorator = Decorator.new(mock_nameable)
      decorator.correct_name
    end
  end
end
