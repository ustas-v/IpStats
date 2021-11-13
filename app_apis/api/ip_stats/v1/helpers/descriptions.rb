# frozen_string_literal: true

module API::IpStats::V1::Helpers::Descriptions
  extend ActiveSupport::Concern

  class_methods do
    def success_desc(message, model, session_auth: false)
      desc = { code: 200, message: message, model: "API::IpStats::V1::Entities::#{model}" }
      desc.merge!(
        headers: {
          'X-Session-Token' => {
            description: 'User Session Token', required: true, type: :string
          }
        }
      ) if session_auth
      desc
    end

    def failure_desc
      [
        { code: 401, message: 'Authentication error',
          model: API::IpStats::V1::Entities::Error },
        { code: 403, message: 'Authorization error',
          model: API::IpStats::V1::Entities::Error },
        { code: 404, message: 'Resource not found',
          model: API::IpStats::V1::Entities::Error },
        { code: 422, message: 'Validaation error',
          model: API::IpStats::V1::Entities::Error }
      ]
    end
  end
end
