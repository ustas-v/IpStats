# frozen_string_literal: true

module API::IpStats::V1::Entities
  class Error < Grape::Entity
    expose :code,
           documentation: {
             type: 'Integer',
             desc: 'Code error',
             required: true
           }
    expose :error,
           documentation: {
             type: 'String',
             desc: 'Error message',
             required: true
           }
    expose :reason,
           documentation: {
             type: 'String',
             desc: 'Error reason',
             required: false
           }
  end
end
