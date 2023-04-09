class HomeController < ApplicationController
  def index
    searcher = SearchWeather.new(city: params[:city])
    @city = searcher.run
    SearchHistory.save(user: current_user, city: @city)
    @last_cities_found = SearchHistory.fetch(user: current_user)
  end
end
  