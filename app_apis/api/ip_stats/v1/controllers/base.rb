# frozen_string_literal: true

module API::IpStats::V1::Controllers
  class Base < Grape::API
    helpers ::API::IpStats::V1::Helpers::Params
  end
end
