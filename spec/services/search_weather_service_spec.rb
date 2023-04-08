RSpec.describe SearchWeather do
  describe "found city weather" do
    it "should get the searched Lima weather status", :vcr do
      allow(City).to receive(:exists?).and_return(true)
      allow(City).to receive(:find_by).and_return(OpenStruct.new({"iata": "LIM"}))

      searcher = SearchWeather.new(city: "Lima")
      city_weather = searcher.run
      expect(searcher).to be_success

      expect(city_weather.name).to eq("Lima")
      expect(city_weather.iata).to eq("LIM")
      expect(city_weather.celsius_temp).to be_kind_of(Integer)
      expect(city_weather.celsius_temp).to be_between(-30,55)
      expect(city_weather.fahrenheit_temp).to be_kind_of(Integer)
      expect(city_weather.fahrenheit_temp).to be_between(-22,131)
      expect(city_weather.condition).to be_kind_of(String)
      # expect(city_weather.condition_icon).to be_a_url
      expect(city_weather.full_name).to be_present
      
    end
    it "should get the searched Lima LIM weather status", :vcr do

      searcher = SearchWeather.new(city: "Lima - LIM")
      city_weather = searcher.run
      expect(searcher).to be_success

      expect(city_weather.name).to eq("Lima")
      expect(city_weather.iata).to eq("LIM")
      expect(city_weather.celsius_temp).to be_kind_of(Integer)
      expect(city_weather.celsius_temp).to be_between(-30,55)
      expect(city_weather.fahrenheit_temp).to be_kind_of(Integer)
      expect(city_weather.fahrenheit_temp).to be_between(-22,131)
      expect(city_weather.condition).to be_kind_of(String)
      # expect(city_weather.condition_icon).to be_a_url
      expect(city_weather.full_name).to be_present
      
    end
    
  end


  describe "dont found city weather" do
    it "handles an empty string as city" do
      searcher = SearchWeather.new(city: "")
      city_weather = searcher.run
      expect(searcher).not_to be_success

      expect(city_weather).not_to be_present
    end
    it "handles no city param" do
      searcher = SearchWeather.new(city: nil)
      city_weather = searcher.run
      expect(searcher).not_to be_success

      expect(city_weather).not_to be_present
    end
    it "handles a city without iata" do
      allow(City).to receive(:exists?).and_return(false)
      
      searcher = SearchWeather.new(city: "")
      city_weather = searcher.run
      expect(searcher).not_to be_success

      expect(city_weather).not_to be_present
    end
  end

  describe "cache enabled" do
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
    let(:cache) { Rails.cache }

    before(:each) do
      allow(Rails).to receive(:cache).and_return(memory_store)
      Rails.cache.clear
    end

    it "fetches city from cache", :vcr do
      city = "Lima"
      cache_key = "weather:#{city}"

      expect(Rails.cache.exist?(cache_key)).to be_falsy
      searcher = SearchWeather.new(city: "Lima")
      city_weather = searcher.run
      expect(Rails.cache.read(cache_key)).to eq(searcher.weather)

    end
  end
  
end