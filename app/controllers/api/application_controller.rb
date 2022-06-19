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
      uri = "http://dataservice.accuweather.com/locations/v1/#{key}"
      headers = { 'Accept-Encoding' => 'gzip', 'Content-Type' => 'application/json; charset=utf-8' }
      query = { 'apikey' => ENV.fetch('ACCUWEATHER_KEY'), 'language' => 'ru-ru' }
      result = HTTParty.get(uri, query:, headers:)
      city.name = JSON.parse(result.body)['EnglishName']
      city.save
      city
    end
  end
end
