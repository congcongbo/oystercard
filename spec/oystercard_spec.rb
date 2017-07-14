require 'oystercard'

describe Oystercard do

  let(:station) {double :station}

    describe '#balance' do
      it 'shows balance of 0 for newly initiated card' do
        expect(subject.balance).to eq 0
      end
    end

    describe '#top_up' do
      it 'tops up the balance when requested' do
        subject.top_up(Oystercard::MAX_BALANCE)
        expect(subject.balance).to eq Oystercard::MAX_BALANCE
      end

      it 'sets maximum limit of £90' do
        subject.top_up(Oystercard::MAX_BALANCE)
        expect { subject.top_up 1 }.to raise_error "You tried to increase your balance by #{Oystercard::MAX_BALANCE + 1}. This is impossible! The maximum limit is £#{Oystercard::MAX_BALANCE}!"
      end
    end

    describe '#deduct' do
      it 'deducts amount from card' do
        subject.top_up(Oystercard::MAX_BALANCE)
        expect { subject.deduct 5 }.to change { subject.balance }.by -5
      end
    end

    describe '#touch_in' do
    it 'sets minimim balance for touch in to be allowed' do
      card = Oystercard.new
      expect { card.touch_in(station) }.to raise_error "You must have a minimum balance of £#{Oystercard::MIN_BALANCE}!"
    end
  end

    describe '#new' do
    it 'starts with in_journey false value upon initialization' do
      expect(subject).not_to be_in_journey
    end
  end

    describe '#in_journey?' do
    before(:each) { subject.top_up(1) }
    it 'changes in_journey to true with touch_in' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'changes in_journey to false with touch_out' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end
  end

    describe '#touch_out' do
    it 'charges on touch_out' do
      subject.top_up(1)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MIN_CHARGE)
    end
  end

    describe '#entry_station' do
    it 'stores the entry station' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

    describe '#exit_station' do
    it 'stores the exit station' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.exit_station).to eq station
    end
  end

    describe '#journeys' do
    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    it 'stores the entry and exit stations in the jouneys array' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journeys).to eq [{entry: station, exit: station}]
    end

  end

end
