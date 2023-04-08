RSpec.describe HomeController, type: :controller do
  describe 'index' do
    it 'calls the search weather service with parameters' do
      searcher = instance_spy(SearchWeather,success?: true)
      allow(SearchWeather).to receive(:new).and_return(searcher)

      get :index, params: {city: "Lima"}
      expect(SearchWeather).to have_received(:new).with(city: "Lima")
    end
  end
end