RSpec.feature 'Sign Up', :devise do

  context "with valid credentials" do
    scenario 'visitor can sign up with valid email address and password' do
      sign_up_with('test@example.com', 'please123', 'please123')
      txts = [I18n.t( 'devise.registrations.signed_up'), I18n.t( 'devise.registrations.signed_up_but_unconfirmed')]
      
      expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
    end
  end
  
  context "with invalid credentials" do
    scenario 'visitor cannot sign up with invalid email address' do
      sign_up_with('bogus', 'please123', 'please123')
      expect(page).to have_content 'Email is invalid'
    end
  
    scenario 'visitor cannot sign up without password' do
      sign_up_with('test@example.com', '', '')
      expect(page).to have_content "Password can't be blank"
    end
  
    scenario 'visitor cannot sign up without password confirmation' do
      sign_up_with('test@example.com', 'please123', '')
      expect(page).to have_content "Password confirmation doesn't match"
    end
  
    scenario 'visitor cannot sign up with mismatched password and confirmation' do
      sign_up_with('test@example.com', 'please123', 'mismatch')
      expect(page).to have_content "Password confirmation doesn't match"
    end
  end

end
