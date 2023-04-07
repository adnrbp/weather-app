class SearchWeather
  API_KEY = Rails.application.credentials.dig(:weather_api,:key)

  attr_accessor :city
  attr_reader :weather

  def initialize(city:)
    @weather_client = WeatherApi::Client.new(API_KEY)
    @success = false
    city = parse_city(city)
    @city = city
  end

  def run
    return unless valid_city?(@city)
    @weather = search(city)
    show_weather_info
  end

  def success?
    @success
  end


  private
  attr_accessor :iata_code
  def parse_city(city)
    return city unless city.include? "-"
    iata_code = city.split("- ")[1]
    "iata:#{iata_code}"
    #@iata = City.find_by_name(city.capitalize).iata
  end

  def valid_city?(city)
    return false if city.empty?
    return true if city.include? "iata:"
    true
    #return false unless City.exists?(name: city.capitalize)
    #if City.exists?(name: city.capitalize)
      #@iata = City.find_by_name(city.capitalize).iata
  end

  def search(city)
    response = Rails.cache.fetch(city, namespace: "weather", skip_nil: true, expires_in: 1.hour) do
      print "MAKING A REQUEST ***********#{city}***"
      @weather_client.city_weather(city)
    end
    @success = response.is_a?(Hash)
    response
  end

  def show_weather_info
    info= {
      :date => formatted_date,
      :time => local_time,
      :name => location("name"),
      :iata => @iata_code || "",
      :full_name => full_location,
      :latitude => location("lat"),
      :longitude => location("lon"),
      :celsius_temp => temperature("temp_c"),
      :fahrenheit_temp => temperature("temp_f"),
      :condition => temperature_condition("text"),
      :condition_icon => temperature_condition("icon") 
    }
    OpenStruct.new(info)
  end

  def location(attrib)
    @weather["location"][attrib]
  end

  def temperature(attrib)
    @weather["current"][attrib].to_i
  end
  def temperature_condition(attrib)
    @weather["current"]["condition"][attrib]
  end

  def formatted_date
    Date.today.strftime("%A, %B %d")
  end

  def local_time
    city_time = @weather["location"]["localtime"].to_s
    api_time_format = "%Y-%m-%d  %H:%M"
    custom_format = "%H:%M %A, %B %d"
    DateTime.strptime(city_time,api_time_format).strftime(custom_format)
  end

  def full_location
    "#{@weather["location"]["name"]}, #{@weather["location"]["country"]}"
  end


  
end