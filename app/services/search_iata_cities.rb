class SearchIataCities

  def initialize(city:)
    @city = city.downcase
  end

  def run
    City.where("name LIKE ? ", "#{@city}%").limit(10)
  end
end
