# frozen_string_literal: true

module API::IpStats::V1::Controllers
  class Hosts < Base

    resource :hosts do

      # POST /hosts.json
      desc 'Create host' do
        success ::API::IpStats::V1::Base.success_desc 'Host', 'Host'
        failure ::API::IpStats::V1::Base.failure_desc
        detail 'Created Host'
      end
      params do
        requires :ip_address, type: String, desc: 'IP address'
        optional :state, type: String, desc: 'State'
      end

      post do
        host = Host.create!(declared(params, include_missing: false))

        present host, with: API::IpStats::V1::Entities::Host
      end

      route_param :ip_address, requirements: { ip_address: /[0-9.]*/ } do
        # DELETE /hosts/:ip_address.json
        desc 'Delete host' do
          success ::API::IpStats::V1::Base.success_desc 'Host', 'Host'
          failure ::API::IpStats::V1::Base.failure_desc
          detail 'Deleted Host'
        end

        delete do
          host = Host.by_ip_address(params[:ip_address]).take!

          present host.destroy, with: API::IpStats::V1::Entities::Host
        end

        # GET /hosts/:ip_address/ping_stats.json
        desc 'Get ping statistics' do
          success ::API::IpStats::V1::Base.success_desc 'PingStats', 'PingStats'
          failure ::API::IpStats::V1::Base.failure_desc
          detail 'PingStats'
        end
        params do
          requires :datetime_from, type: DateTime, desc: 'Datetime from'
          requires :datetime_to, type: DateTime, desc: 'Datetime to'
        end

        get :ping_stats do
          host  = Host.by_ip_address(params[:ip_address]).take!
          stats = ::Services::Stats::Hosts::PingFetcher.run!(
            host: host,
            datetime_from: params[:datetime_from],
            datetime_to: params[:datetime_to]
          )

          if stats.min_rtt.nil?
            error!({ error: 'Empty statistics data', reason: 'PingStats', code: 204 }, 200)
          else
            present stats, with: API::IpStats::V1::Entities::PingStats
          end
        end
      end
    end
  end
end
