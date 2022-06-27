# frozen_string_literal: true

module Api
  module Weather
    # Historical (24) hours
    class HistoricalController < Api::WeatherController
      def index
        city = find_city
        if city.weather_current?('historical')
          render json: city.weathers.historicals.last.historical
        else
          actual = AccuweatherApi.historical(city.location_key)
          city.weathers.create(historical: actual)
          render json: actual
        end
      end

      def min
        city = find_city
        if city.weather_current?('historical')
          actual = city.weathers.historicals.last.historical
        else
          actual = AccuweatherApi.historical(city.location_key)
          city.weathers.create(historical: actual)
        end
        render json: { Minimum: sort_json(actual)[0] }
      end

      def max
        city = find_city
        if city.weather_current?('historical')
          actual = city.weathers.historicals.last.historical
        else
          actual = AccuweatherApi.historical(city.location_key)
          city.weathers.create(historical: actual)
        end
        render json: { Maximum: sort_json(actual)[-1] }
      end

      def avg
        city = find_city
        if city.weather_current?('historical')
          actual = city.weathers.historicals.last.historical
        else
          actual = AccuweatherApi.historical(city.location_key)
          city.weathers.create(historical: actual)
        end
        array = JSON.parse(actual).map { |hour| hour['Temperature']['Metric']['Value'] }
        render json: { Average: (array.sum / array.size).round }
      end

      private

      def sort_json(json)
        JSON.parse(json).sort_by { |hour| hour['Temperature']['Metric']['Value'] }
      end
    end
  end
end
