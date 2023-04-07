
RSpec.describe User do
  xit "should response a successful status" do
    # Arrange
    API_KEY = "test-key"
    weather_client = WeatherApi::Client.new(API_KEY)
    # Act
    city_weather = weather_client.city_weather('Lima')
    # Assert
    expect(city_weather).to be_a(Hash)
    expect(city_weather).to match(hash_including('location'))
    expect(city_weather).to include(
      "location" => be_a(Hash)
    )
    expect(city_weather).to match(hash_including(
      "location" => hash_including("name" => "Lima")
    ))
  end
  
end