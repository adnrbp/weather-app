class CitiesController < ApplicationController
  before_action :force_json, only: :search

  def search
    searcher = SearchIataCities.new(city: params[:q])
    @cities = searcher.run
  end

  private

  def force_json
    request.format = :json
  end
end
