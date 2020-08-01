RSpec.describe Lazy::TimeRange do
  context '.new' do
    it 'does not fail with one range arguments' do
      expect { Lazy::TimeRange.new(1..2) }.not_to raise_error
    end

    it 'does not fail with two arguments' do
      expect { Lazy::TimeRange.new(1, 2) }.not_to raise_error
    end

    it 'fails with more than expected arguments' do
      expect { Lazy::TimeRange.new(1, 2, 3) }.to raise_error(ArgumentError)
    end
  end
  context '#to_a' do
    it 'returns an Array or integers for integer arguments' do
      range = Lazy::TimeRange.new(1, 2)
      all = range.to_a.all? { |a| a.is_a?(Integer) }
      expect(all).to be(true)
    end
    it 'returns an Array or times for time arguments' do
      range = Lazy::TimeRange.new(Time.now, Time.now + 100_000)
      all = range.to_a.all? { |a| a.is_a?(Time) }
      expect(all).to be(true)
    end
  end
end
