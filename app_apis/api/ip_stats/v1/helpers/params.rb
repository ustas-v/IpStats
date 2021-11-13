# frozen_string_literal: true

module API::IpStats::V1::Helpers::Params
  extend Grape::API::Helpers

  params :pagination do
    optional :page, type: Integer, default: 1, desc: 'Number of page'
    optional :per_page, type: Integer, default: 20, desc: 'Count records'
  end
end