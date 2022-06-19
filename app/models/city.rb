# frozen_string_literal: true

class City < ApplicationRecord
  has_many :weathers, class_name: 'Weather', dependent: :destroy

  def weather_current?(klass)
    if weathers.size.positive?
      last = weathers.last
      ((Time.current - last.created_at) / 60.minute).round.zero? && !last.send(klass).nil?
    else
      false
    end
  end
end
