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
end
