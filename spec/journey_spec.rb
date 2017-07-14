require 'journey'

describe Journey do

  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}
  let(:journey) {described_class.new(entry_station)}

  describe '#entry_station' do
    it 'has an entry station on initialization' do
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe '#exit' do
    it 'has an exit station on touch_out' do
      journey.exit(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  describe '#journey_log' do
    it 'returns the journey with entry and exit stations' do
      journey.exit(exit_station)
      expect(journey.journey_log).to eq({entry: entry_station, exit: exit_station})
    end
  end

  describe '#complete?' do
    it 'knows the journey is complete' do
      journey.exit(exit_station)
      expect(journey.complete?).to eq true
    end

    it 'knows journey is incomplete' do
      expect(journey.complete?).to eq false
    end
  end

  describe 'fare' do
    it 'returns the minimum fare if both touch_in and touch_out happened' do
      journey.exit(exit_station)
      expect(journey.fare).to eq 1
    end

    it 'returns the penalty of 6 if either touch_in or touch_out happened' do
      expect(journey.fare).to eq 6
    end
  end

end
