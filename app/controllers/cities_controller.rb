class CitiesController < ApplicationController
  before_action :force_json, only: :search

  def search
    q = params[:q].downcase
    @cities = City.where("name LIKE ? ", "#{q}%").limit(10)
  end

  private

  def force_json
    request.format = :json
  end
end
