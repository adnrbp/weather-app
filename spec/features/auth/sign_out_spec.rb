RSpec.feature 'Sign Out', :devise do

  scenario 'user signs out successfully' do
    user = create(:user, :confirmed)
    signin(user.email, user.password)

    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    click_link 'Sign out'
    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end

end
