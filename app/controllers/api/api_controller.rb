# frozen_string_literal: true

module Api
  class ApiController < Api::ApplicationController
    def health
      status = { "status": 'OK' }
      render json: status
    end
  end
end
