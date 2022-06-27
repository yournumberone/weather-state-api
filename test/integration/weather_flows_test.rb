# frozen_string_literal: true

require 'test_helper'

class WeatherFlowsTest < ActionDispatch::IntegrationTest
  def setup; end

  test 'get current weather' do
    VCR.use_cassette('Paris current weather') do
      get api_weather_current_url, params: { 'city': 623 }
    end
    temperature = JSON.parse(response.body)[0]['Temperature']['Metric']['Value']
    assert { temperature.to_i == 17 }
  end

  test 'get closest weather for city by time' do
    get api_weather_by_time_url, params: { 'city': 100, 'timestamp': Time.now.to_i }
    assert { response.body == 'recent' }
  end

  test 'returns 404 if city does not have weathers story' do
    get api_weather_by_time_url, params: { 'city': 700, 'timestamp': Time.now.to_i }
    assert_response :missing
  end

  test 'get historical of 24 hours' do
    VCR.use_cassette('Paris historical 24') do
      get api_weather_historical_url, params: { 'city': 623 }
    end
    historical_list = JSON.parse(response.body)
    assert { historical_list.size == 24 }
  end

  test 'get max of 24 hours' do
    VCR.use_cassette('Paris historical 24') do
      get api_weather_historical_max_url, params: { 'city': 623 }
    end
    value = JSON.parse(response.body)['Maximum']['Temperature']['Metric']['Value']
    assert { value.to_i == 21 }
  end

  test 'get min of 24 hours' do
    VCR.use_cassette('Paris historical 24') do
      get api_weather_historical_min_url, params: { 'city': 623 }
    end
    value = JSON.parse(response.body)['Minimum']['Temperature']['Metric']['Value']
    assert { value.to_i == 14 }
  end

  test 'get avg of 24 hours' do
    VCR.use_cassette('Paris historical 24') do
      get api_weather_historical_avg_url, params: { 'city': 623 }
    end
    value = JSON.parse(response.body)['Average']
    assert { value.to_i == 18 }
  end
end
