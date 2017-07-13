require 'oystercard'

describe Oystercard do

  let(:station) {double :station}

  describe '#balance' do
    it 'shows balance of 0 for newly initiated card' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#change_balance' do
    before(:each) { subject.top_up(Oystercard::MAX_BALANCE) }
    it 'tops up the balance when requested' do
      expect(subject.balance).to eq Oystercard::MAX_BALANCE
    end

    it 'sets maximum limit of £90' do
      expect { subject.top_up 1 }.to raise_error "You tried to increase your balance by #{Oystercard::MAX_BALANCE + 1}. This is impossible! The maximum limit is £#{Oystercard::MAX_BALANCE}!"
    end

    it 'deducts amount from card' do
      expect { subject.deduct 5 }.to change { subject.balance }.by -5
    end
  end

  describe '#journey' do
    it 'sets minimim balance for touch in to be allowed' do
      card = Oystercard.new
      expect { card.touch_in(station) }.to raise_error "You must have a minimum balance of £#{Oystercard::MIN_BALANCE}!"
    end

    it 'shows the entry_station as nil before touch_in' do
      card = Oystercard.new
      expect(card.entry_station).to be_nil
    end

    before(:each) { subject.top_up(Oystercard::MAX_BALANCE) }

    it 'starts with in_journey false value upon initialization' do
      #expect(subject.in_journey?).to eq false
      expect(subject).not_to be_in_journey
    end

    it 'changes in_journey to true with touch_in' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'changes in_journey to false with touch_out' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it 'charges on touch_out' do
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MIN_CHARGE)
    end

    it 'stores the entry station' do
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'stores the exit station' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.exit_station).to eq station
    end

  end
end
