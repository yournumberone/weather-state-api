# frozen_string_literal: true

module Api
  class WeatherController < Api::ApplicationController
    def current
      city = find_city
      if city.weather_current?('current')
        render json: city.weathers.last.current
      else
        fresh = clone_current
        city.weathers.create(current: fresh)
        render json: fresh
      end
    end

    def by_time
      array = find_city.weathers.currents
      if array.size.positive? && params[:timestamp]
        closest = (array.sort_by { |weather| p (weather.created_at.to_i - params[:timestamp]).abs }).first
        render json: closest.current
      else
        render json: { 404 => 'Not Found' }
      end
    end

    private

    def clone_current
      base_uri = "http://dataservice.accuweather.com/currentconditions/v1/#{set_location}"
      headers = { 'Accept-Encoding' => 'gzip', 'Content-Type' => 'application/json; charset=utf-8' }
      query = { 'apikey' => ENV.fetch('ACCUWEATHER_KEY'), 'language' => 'ru-ru', 'details' => 'true' }
      result = HTTParty.get(base_uri, query:, headers:)
      result.body
    end
  end
end
