# frozen_string_literal: true

module API::IpStats::V1::Entities
  class Host < Base
    expose :id,
            documentation: {
              type: 'Integer', required: true,
              desc: 'ID'
            }
    expose :ip_address,
            documentation: {
              type: 'String', required: true,
              desc: 'IP address'
            }
    expose :state,
            documentation: {
              type: 'String', required: true,
              desc: 'State'
            }
    expose :created_at,
            documentation: {
              type: 'String', required: true,
              desc: 'Created at'
            }

    tag_description :hosts, 'Hosts'
  end
end
