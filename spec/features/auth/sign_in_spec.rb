RSpec.feature 'Sign In', :devise do

  context "not registered" do
    scenario 'user cannot sign in if not registered' do
      signin('test@example.com', 'please123')
      expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
    end
  end

  context "with valid credentials" do
    scenario 'user can sign in with valid credentials' do
      user = FactoryBot.create(:user, :confirmed)
      signin(user.email, user.password)
      expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    end

    scenario 'user can sign Up w/ Confirmable Email and Log in ' do
      user = FactoryBot.create(:user)

      mail = ActionMailer::Base.deliveries[0]
      token = mail.body.decoded.match(/confirmation_token=([^"]+)/)[1]
      assert_equal user.confirmation_token, token

      visit "users/confirmation?confirmation_token=#{token}"
      expect(page).to have_content I18n.t 'devise.confirmations.confirmed'

      signin(user.email, user.password)

      expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    end
  end

  context "with invalid credentials" do
    scenario 'user cannot sign in with wrong email' do
      user = create(:user)
      signin('invalid@email.com', user.password)
      expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'Email'
    end

    scenario 'user cannot sign in with wrong password' do
      user = create(:user)
      signin(user.email, 'invalidpass')
      expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'Email'
    end
  end
end
