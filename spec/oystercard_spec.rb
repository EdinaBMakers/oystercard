require 'oystercard'

describe Oystercard do
  let(:subject) { Oystercard.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'has 0 balance by default' do
    expect(subject.balance).to eq(0)
  end

  it 'can be topped up' do
    subject.top_up(10)

    expect(subject.balance).to eq(10)
  end

  it 'raises error if the new balance would exceed the default limit' do
    subject.top_up(Oystercard::DEFAULT_MAX_BALANCE)

    expect { subject.top_up(1) }.to \
    raise_error("Balance can't be more than #{Oystercard::DEFAULT_MAX_BALANCE}")
  end

  it 'is not in use by default' do
    expect(subject).not_to be_in_journey
  end

  it 'is in use after touch in' do
    subject.top_up(Oystercard::SINGLE_FARE)
    subject.touch_in(entry_station)

    expect(subject).to be_in_journey
  end

  it 'is not in use after touch out' do
    subject.top_up(Oystercard::SINGLE_FARE)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)

    expect(subject).not_to be_in_journey
  end

  it 'raises error when touching in with balance lower than a single fare' do
    expect { subject.touch_in(entry_station) }.to \
    raise_error("Balance is not enough for a single journey")
  end

  it 'charges the card on touch out' do
    subject.top_up(3 * Oystercard::SINGLE_FARE)
    subject.touch_in(entry_station)

    expect { subject.touch_out(exit_station) }.to change \
    {subject.balance}.by(-1 * Oystercard::SINGLE_FARE)
  end

  it 'does not charge the card on touch in' do
    subject.top_up(3 * Oystercard::SINGLE_FARE)

    expect { subject.touch_in(entry_station) }.not_to change { subject.balance }
  end

  it 'does not have entry station by default' do
    expect(subject.entry_station).to be_nil
  end

  it 'remembers the entry station after the touch in' do
    subject.top_up(Oystercard::SINGLE_FARE)
    subject.touch_in(entry_station)

    expect(subject.entry_station).to eq(entry_station)
  end

  it 'forgets the entry station on touch out' do
    subject.top_up(Oystercard::SINGLE_FARE)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)

    expect(subject.entry_station).to be_nil
  end

  it 'adds last journey to journey history on touch out' do
    subject.top_up(Oystercard::SINGLE_FARE)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)

    expect(subject.journey_history).to \
    eq([{:entry_station => entry_station, :exit_station => exit_station}])
  end

  it 'has an empty journey history by default' do
    expect(subject.journey_history).to be_empty
  end
end
