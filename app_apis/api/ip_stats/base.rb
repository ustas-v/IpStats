# frozen_string_literal: true

class API::IpStats::Base < Grape::API

  insert_before Grape::Middleware::Error, GrapeLogging::Middleware::RequestLogger,
    logger: Rails.logger,
    # formatter: LogStashLogger::Formatter::JsonLines.new,
    log_level: :debug,
    include: [
               GrapeLogging::Loggers::ClientEnv.new,
               GrapeLogging::Loggers::RequestHeaders.new,
               GrapeLogging::Loggers::FilterParameters.new
             ]

  mount ::API::IpStats::V1::Base

  # Next version:
  # mount V1_1::Base

  # Next version:
  # mount V2::Base

  # and etc.
end
