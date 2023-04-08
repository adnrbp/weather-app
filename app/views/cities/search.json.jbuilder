json.array!(@cities) do |city|
  json.country city.country
  json.city_iata city.name + ' - ' + city.iata
end