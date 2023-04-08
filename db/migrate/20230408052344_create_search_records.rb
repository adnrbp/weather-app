class CreateSearchRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :search_records do |t|
      t.references :city, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
