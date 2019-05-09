require 'station'

describe Station do
  STATION_NAME = "Stratford"
  ZONE =2
  let(:subject) { Station.new(STATION_NAME, ZONE) }

  it 'has a name' do
    expect(subject.name).to eq(STATION_NAME)
  end

  it 'has a zone' do
    expect(subject.zone).to eq(ZONE)
  end
end
