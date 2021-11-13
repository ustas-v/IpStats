# frozen_string_literal: true

module API::IpStats::V1::Entities
  class Base < Grape::Entity
    include ::Rails.application.routes.url_helpers

    class << self
      def tag_description(tag_name, description)
        @@tags ||= []
        @@tags << { name: tag_name, description: description }
      end

      def tags
        @@tags ||= []
      end
    end
  end
end
