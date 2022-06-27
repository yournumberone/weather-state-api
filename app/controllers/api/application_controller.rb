# frozen_string_literal: true

module Api
  class ApplicationController < ApplicationController
    protected

    def set_location
      params[:city] || City.last.location_key
    end

    def find_city
      key = set_location
      city = City.find_by(location_key: key)
      return city unless city.nil?

      city = City.new(location_key: key)
      city.name = AccuweatherApi.city_info(key)
      city.save
      city
    end
  end
end
