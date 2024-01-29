require 'rails_helper'

RSpec.describe LocationsFacade do
  describe '#locations' do
    let(:name) { 'Coffee Shop' }
    let(:city) { 'Denver' }
    let(:locations_facade) { LocationsFacade.new(name, city) }

    before do
      service_double = instance_double(LocationsService)
      allow(LocationsService).to receive(:new).and_return(service_double)
      allow(service_double).to receive(:get_location_results).with(name, city).and_return([
        { attributes: { name: 'Cafe1', address: '123 Main St, Denver', rating: 4.5 } },
        { attributes: { name: 'Cafe2', address: '456 Elm St, Denver', rating: 4.0 } }
      ])
    end

    it 'returns an array of SearchResult objects with the correct attributes' do
      results = locations_facade.locations

      expect(results).to all(be_a(SearchResult))
      expect(results.size).to eq(2)

      expect(results[0].name).to eq('Cafe1')
      expect(results[0].address).to eq('123 Main St, Denver')

      expect(results[1].name).to eq('Cafe2')
      expect(results[1].address).to eq('456 Elm St, Denver')
    end
  end
end
