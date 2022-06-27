# frozen_string_literal: true

class City < ApplicationRecord
  has_many :weathers, class_name: 'Weather', dependent: :destroy

  def weather_current?(type)
    if weathers.size.positive?
      last = weathers.last
      ((Time.current - last.created_at) / 60.minute).round.zero? && !last.send(type).nil?
    else
      false
    end
  end

  def closest(timestamp)
    array = weathers.currents
    return nil if array.size.zero? || timestamp.nil?

    (array.sort_by { |weather| (weather.created_at.to_i - timestamp.to_i).abs }).first
  end
end
