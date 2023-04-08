class HomeController < ApplicationController
  def index
    searcher = SearchWeather.new(city: params[:city])
    @city = searcher.run
  end
end
  