require_relative './spec_helper'
require_relative '../bin/watering_cli'

RSpec.describe App do
  subject { described_class }

  describe 'basic functionality' do
    it 'runs' do
      subject
    end

    it 'can use Plant module methods' do
      expect(subject.test).to eq(42)
    end

    it 'can load Plants' do
      subject.load_plants
    end
  end

  describe '.opt_handler' do
    # TODO: DRY the expect(subject.opt_handler(arguments))?

    # To describe what option handler does
    # -p flag is used to call a specific Plant
    context 'when option -p is provided' do
      # when a plant that is in the JSON file is called
      # it should return the expected number of watering dates
      it 'returns 7 dates for valid plant input' do
        arguments = ['-p', 'Jade']
        expect(subject.opt_handler(arguments).size).to eq(7)
      end
      # when a plant that is not in the JSON file is called
      # it should return an Error string (should it raise Error instead?)
      it 'returns Error for invalid plant input' do
        arguments = ['-p', 'Meow']
        expect(subject.opt_handler(arguments)).to eq('Error: plant not found')
      end
    end
    # -d flag is used to list plants watered on a specific date
    context 'when option -d is provided' do
      # when an appropriate date is given
      # it should return a series of plant names
      it 'returns 7 dates for valid date input: "2020-02-24"' do
        arguments = ['-d', '2020-02-24']
        expect(subject.opt_handler(arguments).size).to eq(7)
      end
      # it should return a series of plant names or [] if there are no plants to water today
      # TODO: this is broken
      it 'returns success for valid date input: "today"' do
        arguments = ['-d', 'today']
        expect(subject.opt_handler(arguments).class).to eq(Array)
      end
      # when an inappropriate date is given
      # it should return an Error string
      # TODO : this is broken
      it 'returns Error for invalid date input' do
        arguments = ['-d', 'Meow']
        expect(subject.opt_handler(arguments)).to eq('Error: plant not found')
      end
    end

    context 'when option -a is provided' do
      # it should return everything
      it 'return all plants and dates' do
        arguments = ['-a']
        expect(subject.opt_handler(arguments).size).to eq(11)
      end
    end

    context 'when an invalid option is provided' do
      # it should return everything
      it 'raises an ArgumentError' do
        arguments = ['-z']
        expect { subject.opt_handler(arguments) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.default_settings' do
    context 'no arguments are provided' do
      subject { described_class.default_settings }
      # it should return an Array of 11 items
      it 'return all plants and dates' do
        expect(subject.size).to eq(11)
        expect(subject.class).to eq(Array)
        expect(subject.last['name']).to eq('Wavy Fern')
      end
    end
  end

end
