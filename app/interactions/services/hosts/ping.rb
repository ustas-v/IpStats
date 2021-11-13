# frozen_string_literal: true

module Services::Hosts
  class Ping < ActiveInteraction::Base
    PACKETS_COUNT = 10

    object :host

    def execute
      parse_result ping_command
    end

    private

    def ping_command
      @ping_command ||= `ping #{host.ip_address} -c #{PACKETS_COUNT} | tail -2`
    end

    # tsum += triptime;
    # tsum2 += (long long)triptime * (long long)triptime
    # tsum /= nreceived + nrepeats;
    # tsum2 /= nreceived + nrepeats;
    # tmdev = llsqrt(tsum2 - tsum * tsum);

    # mdev = SQRT (SUM (RTT * RTT) / N - (SUM (RTT) / N) ^ 2)

    def parse_result(result)
      packet_loss = result.match(/(\d+)% packet loss/)[1]
      match = result.match(/([0-9.]+)\/([0-9.]+)\/([0-9.]+)\/([0-9.]+)/)

      {
        packet_loss: packet_loss.to_i,
        min:  match[1].to_f,
        avg:  match[2].to_f,
        max:  match[3].to_f,
        mdev: match[4].to_f
      }
    end
  end
end
