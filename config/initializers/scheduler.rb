# frozen_string_literal: true

require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.every '1h' do
  City.all.each do |city|
    next if city.weather_current?('current')

    UpdateCurrentWeatherJob.perform_later(city)
    sleep 15
  end
end
