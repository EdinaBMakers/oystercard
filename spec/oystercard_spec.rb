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

  it 'can be deducted from' do
    subject.top_up(30)
    subject.deduct(10)

    expect(subject.balance).to eq(20)
  end

  it 'is not in use by default' do
    expect(subject).not_to be_in_journey
  end

  it 'is in use after touch in' do
    subject.touch_in

    expect(subject).to be_in_journey
  end

  it 'is not in use after touch out' do
    subject.touch_in
    subject.touch_out

    expect(subject).not_to be_in_journey
  end
end
