require 'factory_bot'

# 3) Configurations
RSpec.configure do |config|
  # 3.5) Load Factory Bot methods (auto-include)
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.factories.clear
    FactoryBot.find_definitions
  end
end
