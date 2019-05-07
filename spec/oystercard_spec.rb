require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }

  it 'has 0 balance by default' do
    expect(card.balance).to eq(0)
  end
end
