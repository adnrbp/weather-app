RSpec.describe SearchWeather do
  describe "found city weather" do
    it "should get the searched Lima weather status", :vcr do

      searcher = SearchWeather.new(city: "Lima")
      city_weather = searcher.run
      expect(searcher).to be_success

      expect(city_weather.name).to eq("Lima")
      # expect(city_weather.iata).to eq("LIM")
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
  end
  
end