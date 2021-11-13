# frozen_string_literal: true

module Services::Stats::Hosts
  class PingFetcher < ActiveInteraction::Base

    object :host

    date_time :datetime_from
    date_time :datetime_to

    def execute
      fetch_stats
    end

    private

    def fetch_stats
      select_fields_sql = <<-SQL
        AVG(rtt) AS avg_rtt,
        MIN(rtt) AS min_rtt,
        MAX(rtt) AS max_rtt,
        AVG(mdev) AS avg_mdev,
        AVG(packet_loss_percent) AS avg_packet_loss_percent,
        PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY rtt) AS median_rtt
      SQL

      stats.select(select_fields_sql).take
    end

    def stats
      @stats ||= host.ping_stats.by_datetime(datetime_from..datetime_to)
    end
  end
end
