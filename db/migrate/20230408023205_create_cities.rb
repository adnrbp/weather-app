class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :country
      t.string :country_abbr
      t.string :world_area_code
      t.string :airport_name
      t.string :iata
      t.string :celsius
      t.string :faren
      t.string :latitude
      t.string :longitude
      t.string :localtime
      t.string :condition
      t.string :condition_icon

      t.timestamps
    end
  end
end
