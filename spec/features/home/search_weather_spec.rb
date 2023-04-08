RSpec.feature 'Search Weather', :devise do
  before(:each) do
    user = FactoryBot.create(:user, :confirmed)
    login_as(user)
    visit authenticated_root_path
  end
  context "cities that have iata" do
    scenario 'user can search for weather status with City name', :vcr do
      fill_in :city, with: "Dubai"
      click_on "Search"
      expect(page).to have_selector(".result__full-name", text: "Dubai, United Arab Emirates")
      expect(page).to have_selector(".result__temperature", count: 2)
      expect(page).to have_selector(".result__latitude", text: "lat: 25.25")
      expect(page).to have_selector(".result__longitude", text: "lon: 55.28")
    end
  
    scenario 'user can search for weather status with City name and iata', :vcr do
      fill_in :city, with: "Dubai - DXB"
      click_on "Search"
      expect(page).to have_selector(".result__full-name", text: "Dubai, United Arab Emirates")
      expect(page).to have_selector(".result__temperature", count: 2)
      expect(page).to have_selector(".result__latitude", text: "lat: 25.25")
      expect(page).to have_selector(".result__longitude", text: "lon: 55.36")
    end
  end

  context "invalid cities" do
    scenario 'user cannot search for weather status with City without iata' do
      fill_in :city, with: "Lebu"
      click_on "Search"
      expect(page).not_to have_selector(".result__temperature", count: 2)
    end

    scenario 'user cannot search for weather status with empty City name' do
      fill_in :city, with: ""
      click_on "Search"
      expect(page).not_to have_selector(".result__temperature", count: 2)
    end
  end

end