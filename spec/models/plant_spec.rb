RSpec.describe Plant, type: :model do
  # TODO: undefined method `reflect_on_association' for Class:Class
  # it { expect(Plant).to have_many(:days) }
  # it { expect(Plant).to have_many(:plant_days) }
  # TODO: undefined method `validate_numericality_of'
  # it { should validate_numericality_of(:water_after) }

  describe 'Basic functionality' do
    subject { described_class }
    it 'runs' do
      subject
    end
  end

  describe 'Validations' do
    subject { described_class.new(name: 'Catnip', water_after: 3) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is valid with nil attributes' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it 'is not valid with 0 water after days' do
      subject.water_after = 0
      expect(subject).to_not be_valid
    end
  end

  describe 'Class Methods' do
    describe '.water_all_days' do
      subject { described_class.create(name: 'Catnip', water_after: 3) }
      let(:date) { Date.parse('2019-12-06') }

      it 'should return true for valid dates' do
        expect(subject.water_all_days(date, date + 2.days)).to eq(true)
      end

      it 'should return false for invalid dates' do
        expect(subject.water_all_days(date + 2.days, date)).to eq(false)
      end
    end
  end
end
