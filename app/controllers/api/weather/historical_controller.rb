# frozen_string_literal: true

module Api
  module Weather
    class HistoricalController < Api::WeatherController
      def index
        city = find_city
        if city.weather_current?('historical')
          render json: city.weathers.last.historical
        else
          fresh = clone_historical
          city.weathers.create(historical: fresh)
          render json: fresh
        end
      end

      def min
        city = find_city
        if city.weather_current?('historical')
          actual = city.weathers.last.historical
        else
          actual = clone_historical
          city.weathers.create(historical: actual)
        end
        render json: { Minimum: sort_json(actual)[0] }
      end

      def max
        city = find_city
        if city.weather_current?('historical')
          actual = city.weathers.last.historical
        else
          actual = clone_historical
          city.weathers.create(historical: actual)
        end
        render json: { Maximum: sort_json(actual)[-1] }
      end

      def avg
        city = find_city
        if city.weather_current?('historical')
          actual = city.weathers.last.historical
        else
          actual = clone_historical
          city.weathers.create(historical: actual)
        end
        array = JSON.parse(actual).map { |hour| hour['Temperature']['Metric']['Value'] }
        render json: { Average: (array.sum / array.size).round }
      end

      private

      def clone_historical
        base_uri = "http://dataservice.accuweather.com/currentconditions/v1/#{set_location}/historical/24"
        headers = { 'Accept-Encoding' => 'gzip', 'Content-Type' => 'application/json; charset=utf-8' }
        query = { 'apikey' => ENV.fetch('ACCUWEATHER_KEY'), 'language' => 'ru-ru' }
        result = HTTParty.get(base_uri, query:, headers:)
        result.body
      end

      def sort_json(json)
        JSON.parse(json).sort_by { |hour| hour['Temperature']['Metric']['Value'] }
      end
    end
  end
end
