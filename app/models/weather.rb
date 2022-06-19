# frozen_string_literal: true

class Weather < ApplicationRecord
  belongs_to :city

  scope :currents, -> { where('current IS NOT NULL') }
end
