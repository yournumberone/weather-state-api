# frozen_string_literal: true

class UpdateCurrentWeatherJob < ApplicationJob
  queue_as :default

  def perform(city)
    result = AccuweatherApi.current(city.location_key)
    city.weathers.create(current: result)
  rescue StandardError
    Rails.logger.info 'Error on UpdateCurrentWeatherJob'
  end
end
