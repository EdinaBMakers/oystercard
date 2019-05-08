require 'oystercard'

describe Oystercard do
  let(:subject) { Oystercard.new }

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
    subject.touch_in

    expect(subject).to be_in_journey
  end

  it 'is not in use after touch out' do
    subject.top_up(Oystercard::SINGLE_FARE)
    subject.touch_in
    subject.touch_out

    expect(subject).not_to be_in_journey
  end

  it 'raises error when touching in with balance lower than a single fare' do
    expect { subject.touch_in }.to \
    raise_error("Balance is not enough for a single journey")
  end

  it 'charges the card on touch out' do
    subject.top_up(3 * Oystercard::SINGLE_FARE)
    subject.touch_in
    
    expect { subject.touch_out }.to change \
    {subject.balance}.by(-1 * Oystercard::SINGLE_FARE)
  end

  it 'does not charge the card on touch in' do
    subject.top_up(3 * Oystercard::SINGLE_FARE)

    expect { subject.touch_in }.not_to change { subject.balance }
  end
end
