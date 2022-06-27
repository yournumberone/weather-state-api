# frozen_string_literal: true

module Api
  # current weather
  class WeatherController < Api::ApplicationController
    # caches_action :current, layout: false, cache_path: proc { |c| c.request.url }, expires_in: 30.minutes

    def current
      @data = Rails.cache.fetch("current/#{params[:city]}", expires_in: 30.minutes) do
        city = find_city
        UpdateCurrentWeatherJob.perform_now(city) unless city.weather_current?('current')
        city.weathers.currents.last.current
      end
      render json: @data
    end

    def by_time
      city = find_city
      closest = city.closest(params[:timestamp])
      if closest.nil?
        render json: { 404 => 'Not Found' }, status: :not_found
      else
        render json: closest.current
      end
    end
  end
end
