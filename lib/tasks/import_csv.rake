require 'csv'    
desc 'import csv file'

task :import_csv => [ :environment ] do
  puts "Importing data..."

  filename = Rails.root.join("lib", "tasks", "iata_full_p4.csv")
  puts "filename:#{filename}"
  CSV.foreach(filename, headers: true) do |row|
    City.create!(row.to_hash)
  end
end
