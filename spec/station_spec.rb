require 'station'

describe Station do

let(:station) {described_class.new("Kings Cross", 1)}

  it 'has a name on initialization' do
    expect(station.name).to eq "Kings Cross"
  end
  it 'has a zone on initialization' do
    expect(station.zone).to eq 1
  end
end
