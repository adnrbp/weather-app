require 'faraday'

module WeatherApi
  class Client
    API_ENDPOINT = "https://api.weatherapi.com"
    HTTP_OK_CODE = 200
    # attr_reader :api_key

    def initialize(api_key = nil)
      @api_key = api_key
    end

    def city_weather(city)
      request(endpoint: 'v1/current.json',
        params: {
          q: city,
          aqi: "no",
          key: @api_key
        }
      )
    end

    private

      def client
        @_client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.response :json
          client.adapter Faraday.default_adapter
          # client.response :logger do | logger |
          #   def logger.debug *args; end
          # end
        end
      end

      def request(endpoint:, params: {})
        response = client.get(endpoint, params)
        return response.body if successful?(response)
      end

      def successful?(response)
        response.status == HTTP_OK_CODE
      end

  end
end