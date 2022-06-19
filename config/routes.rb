# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    get 'health', to: 'api#health'
    get 'weather/current', to: 'weather#current'
    get 'weather/by_tyme', to: 'weather#by_tyme'
    namespace :weather do
      get 'historical/min', to: 'historical#min'
      get 'historical/max', to: 'historical#max'
      get 'historical/avg', to: 'historical#avg'
      get 'historical', to: 'historical#index'
    end
  end
end
