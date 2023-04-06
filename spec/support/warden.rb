RSpec.configure do |config|
  # 3.8) Configure Warden
  config.include Warden::Test::Helpers, type: :feature
  config.after(type: :feature) { Warden.test_reset! }
end
