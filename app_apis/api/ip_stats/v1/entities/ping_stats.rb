# frozen_string_literal: true

module API::IpStats::V1::Entities
  class PingStats < Base
    expose :min_rtt,
            documentation: {
              type: 'Float', required: true,
              desc: 'Min rtt'
            }
    expose :max_rtt,
            documentation: {
              type: 'Float', required: true,
              desc: 'Max rtt'
            }
    expose :avg_rtt,
            documentation: {
              type: 'Float', required: true,
              desc: 'Avg rtt'
            }
    expose :avg_packet_loss_percent,
            documentation: {
              type: 'Float', required: true,
              desc: 'Loss packets percent'
            }
    expose :avg_mdev,
            documentation: {
              type: 'Float', required: true,
              desc: 'Ыtandard deviation'
            }
    expose :median_rtt,
            documentation: {
              type: 'Float', required: true,
              desc: 'Median rtt'
            }

    tag_description :ping_stats, 'Host ping stats'
  end
end
