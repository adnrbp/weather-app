FactoryBot.define do
  factory :city do
    name { "Dubai" }
    country { "United Arab Emirates" }
    country_abbr { "AE" }
    world_area_code { "971" }
    airport_name { "Dubai" }
    iata { "DXB" }
    celsius { "23" }
    faren { "73" }
    latitude { "25.25" }
    longitude { "55.36" }
    localtime { "06:16 Saturday, April 08" }
    condition { "Mist" }
    condition_icon { "http://cdn.weatherapi.com/weather/64x64/day/143.png" }
  end
end
