# frozen_string_literal: true

module Workers::Stats::Hosts
  class PingCollector < ::Workers::Base
    include Sidekiq::Symbols

    sidekiq_options queue: :statistics, unique: :all, manual: true

    def perform(host_id)
      # For sheduled unique jobs with manual: true only!
      self.class.unlock!(host_id)

      host = ::Host.find host_id

      ::Services::Stats::Hosts::PingCollector.run! host: host

      if host.state_active?
        ::Workers::Stats::Hosts::PingCollector.perform_at(1.minute.from_now, host.id)
      end
    end
  end
end
