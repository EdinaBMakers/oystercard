require 'journey'

describe Journey do
  let(:subject) { Journey.new }
  let(:entry_station) { double :entry_station}
  let(:exit_station) { double :exit_station}

  it 'can be started' do
    expect(subject).to respond_to(:start).with(1).argument
  end

  it 'can be finished' do
    expect(subject).to respond_to(:finish).with(1).argument
  end

  it 'is complete if started and finished' do
    subject.start(entry_station)
    subject.finish(exit_station)

    expect(subject).to be_complete
  end

  it 'is not complete if only started' do
    subject.start(entry_station)

    expect(subject).not_to be_complete
  end

  it 'is not complete if only finished' do
    subject.finish(exit_station)

    expect(subject).not_to be_complete
  end

  it 'is not complete if neither started nor finished' do
    expect(subject).not_to be_complete
  end

  it 'can return fare' do
    expect(subject).to respond_to(:fare)
  end

  it 'returns standard fare if started and finished' do
    subject.start(entry_station)
    subject.finish(exit_station)

    expect(subject.fare).to eq(Journey::STANDARD_FARE)
  end

  it 'returns penalty fare if only started' do
    subject.start(entry_station)

    expect(subject.fare).to eq(Journey::PENALTY_FARE)
  end

  it 'returns penalty fare if only finished' do
    subject.finish(exit_station)

    expect(subject.fare).to eq(Journey::PENALTY_FARE)
  end

  it 'returns penalty fare if neither started nor finished' do
    expect(subject.fare).to eq(Journey::PENALTY_FARE)
  end
end
