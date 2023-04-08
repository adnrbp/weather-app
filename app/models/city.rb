class City < ApplicationRecord
  has_many :search_records
  has_many :users, through: :search_records
end
