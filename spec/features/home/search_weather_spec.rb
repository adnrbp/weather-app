RSpec.feature 'Search City Weather', :devise do
  before(:each) do
    user = FactoryBot.create(:user, :confirmed)
    login_as(user)
    visit authenticated_root_path
    allow(SearchHistory).to receive(:save)
    allow(SearchHistory).to receive(:fetch)
  end
  context "cities that have iata" do

    scenario 'user can search for weather status with City name', :vcr do
      allow(City).to receive(:exists?).and_return(true)
      allow(City).to receive(:find_by).and_return(OpenStruct.new({"iata": "DXB"}))
      
      fill_in :city, with: "Dubai"
      find(".search-button").click
      
      expect(page).to have_selector(".result__full-name", text: "Dubai, United Arab Emirates")
      expect(page).to have_selector(".result__temperature", count: 2)
      expect(page).to have_selector(".result__latitude", text: "lat: 25.25")
      expect(page).to have_selector(".result__longitude", text: "lon: 55.28")
    end
  
    scenario 'user can search for weather status with City name and iata', :vcr do
      fill_in :city, with: "Dubai - DXB"
      find(".search-button").click
      
      expect(page).to have_selector(".result__full-name", text: "Dubai, United Arab Emirates")
      expect(page).to have_selector(".result__temperature", count: 2)
      expect(page).to have_selector(".result__latitude", text: "lat: 25.25")
      expect(page).to have_selector(".result__longitude", text: "lon: 55.36")
    end
  end

  context "invalid cities" do
    scenario 'user cannot search for weather status with City without iata' do
      fill_in :city, with: "Lebu"
      find(".search-button").click
      
      expect(page).not_to have_selector(".result__temperature", count: 2)
    end

    scenario 'user cannot search for weather status with empty City name' do
      fill_in :city, with: ""
      find(".search-button").click
      
      expect(page).not_to have_selector(".result__temperature", count: 2)
    end
  end

end