# frozen_string_literal: true

module Services::Stats::Hosts
  class PingCollector < ActiveInteraction::Base

    object :host

    def execute
      add_ping_stats!
    end

    private

    def add_ping_stats!
      host.ping_stats.create!(
        rtt: stats[:avg],
        mdev: stats[:mdev],
        packet_loss_percent: stats[:packet_loss]
      )
    end

    def stats
      @stats ||= ::Services::Hosts::Ping.run! host: host
    end
  end
end
