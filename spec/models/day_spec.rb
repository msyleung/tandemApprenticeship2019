RSpec.describe Day, type: :model do
  subject { described_class }

  describe 'Basic functionality' do
    it 'runs' do
      subject
    end

    it 'can use Day class methods' do
      expect(subject.count_days(Date.parse('Dec 09 2019'), Date.parse('Dec 16 2019'))).to eq(7)
    end

    # TODO
    # Failure/Error: expected Day to respond to `has_many?`
    # needs shoulda-matchers gem, but still receiving error
    # it { should have_many(:plants) }
    # it { should have_many(:plant_days) }
  end

  describe 'Validations' do
    subject { described_class.new(date: 'Dec 07 2019') }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is valid with nil attributes' do
      subject.date = ''
      expect(subject).to_not be_valid
    end

    it 'is not valid with pre-existing date' do
      subject.date = 'Dec 16 2019'
      expect(subject).to_not be_valid
    end
  end

  describe 'Class Methods' do
    describe '.count_day' do
      let(:date) { Date.parse('2019-12-07') }

      it 'should return 2 days for days between Dec 7 and Dec 9' do
        expect(described_class.count_days(date, date + 2.days)).to eq(2)
      end

      it 'should return 0 days for days between Dec 7 and Dec 7' do
        expect(described_class.count_days(date, date + 0.days)).to eq(0)
      end

      it 'should return -14 days for days between Dec 21 and Dec 7' do
        expect(described_class.count_days(date + 14.days, date)).to eq(-14)
      end
    end

    describe '.check_weekday' do
      let(:date) { Date.parse('2019-12-15') }

      it 'should receive Sunday but return Monday' do
      expect(described_class.check_weekday(date)).to eq(Day.where(date: '2019-  12-16').first)
      end
    end
  end

end
