class SearchHistory
  include Singleton
  class << self
    delegate :save, to: :instance
    delegate :fetch, to: :instance
  end

  def save(user:,city:)

    return unless city.present?
    @city = City.find_by_iata(city.iata)
    searched = SearchRecord.find_or_create_by(user: user,city: @city)
    searched.touch
    
  end

  def fetch(user:)
    user.cities.includes(:search_records).order('search_records.updated_at DESC').first(5)
  end
end