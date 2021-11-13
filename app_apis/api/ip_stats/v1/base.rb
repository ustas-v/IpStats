# frozen_string_literal: true

module API::IpStats::V1
  class Base < Grape::API
    include ::API::IpStats::V1::Helpers::Errors
    include ::API::IpStats::V1::Helpers::Descriptions

    # helpers ::Pundit
    # helpers ::API::IpStats::V1::Helpers::Authentication
    # helpers ::API::IpStats::V1::Helpers::Authorization

    version 'v1', using: :path, vendor: 'IpStats API'
    prefix nil

    content_type :json, 'application/json; charset=UTF-8'
    default_format :json
    format :json

    # Mount controllers with API endpoints
    mount Controllers::Hosts

    add_swagger_documentation(
      api_version: 'v1',
      doc_version: '1.0',
      mount_path: '/docs',
      base_path: '/api/ip_stats',
      info: { title: 'IpStats API' },
      tags: ::API::IpStats::V1::Entities::Base.tags
    )

    route :any, '*path' do
      raise ::API::IpStats::Exceptions::RouteApiPointNotFoundError,
            'Unable to find API endpoint!'
    end
  end
end
