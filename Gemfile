source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# [1] Back-End
gem 'rails', '~> 6.1.0'

# [2] Storage
gem 'sqlite3', '~> 1.4'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# [2.1] APIs
# JSON APIs
gem 'jbuilder', '~> 2.7'


# [3] Front-End
# SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript.
gem 'webpacker', '~> 5.0'
# Faster navigation.
gem 'turbolinks', '~> 5'


# [4] Deployment
# App server
gem 'puma', '~> 5.0'

# [5] Config
# Caching: Reduces boot time
gem 'bootsnap', '>= 1.4.4', require: false

# [6] Tools
# Time Zone info
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


group :development, :test do
  # [6] Tools
  # Debug
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # [6] Tools
  # Debug
  gem 'web-console', '>= 4.1.0'
  # Profiling toolkit: Display Perf. Info.
  gem 'rack-mini-profiler', '~> 2.0'
  # File modifications
  gem 'listen', '~> 3.3'
  # Pre-load app for console, rake and tests.
  gem 'spring'
end


