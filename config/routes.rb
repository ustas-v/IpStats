# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  mount API::IpStats::Base, at: '/api/ip_stats/'
  mount GrapeSwaggerRails::Engine, at: '/swagger'

  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
