# frozen_string_literal: true

class AccuweatherApi
  @headers = { 'Accept-Encoding' => 'gzip', 'Content-Type' => 'application/json; charset=utf-8' }
  @query = { 'apikey' => ENV.fetch('ACCUWEATHER_KEY'), 'language' => 'ru-ru' }

  def self.city_info(location_key)
    uri = "http://dataservice.accuweather.com/locations/v1/#{location_key}"
    result = HTTParty.get(uri, query: @query, headers: @headers)
    JSON.parse(result.body)['EnglishName']
  end

  def self.historical(location_key)
    uri = "http://dataservice.accuweather.com/currentconditions/v1/#{location_key}/historical/24"
    result = HTTParty.get(uri, query: @query, headers: @headers)
    result.body
  end

  def self.current(location_key)
    uri = "http://dataservice.accuweather.com/currentconditions/v1/#{location_key}"
    response = HTTParty.get(uri, query: @query.merge({ 'details' => 'true' }), headers: @headers)
    response.body
  end
end
