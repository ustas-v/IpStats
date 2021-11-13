# frozen_string_literal: true

module API::IpStats::V1::Helpers::Errors
  extend ActiveSupport::Concern

  VALIDATION_ERRORS = [
    Grape::Exceptions::Validation,
    Grape::Exceptions::ValidationArrayErrors,
    Grape::Exceptions::ValidationErrors
  ]

  AI_VALIDATION_ERRORS = [
    ::ActiveInteraction::InvalidInteractionError
  ]

  FATAL_VALIDATION_ERRORS = [
    Grape::Exceptions::InvalidMessageBody
  ]

  # AUTHORIZATION_ERRORS = [
  #   Pundit::NotAuthorizedError
  # ]

  AUTHENTICATION_ERRORS = [
    ::API::IpStats::Exceptions::AuthenticationError,
    ::API::IpStats::Exceptions::EmptySessionToken,
    ::API::IpStats::Exceptions::InvalidSessionToken,
    ::API::IpStats::Exceptions::ExpiredSessionToken
  ]

  included do

    rescue_from *VALIDATION_ERRORS do |e|
      ::Loggers::Validations.logger.info e.full_messages
      error!({ error: e.full_messages, code: 422, reason: e.class.to_s }, 422)
    end

    rescue_from *AI_VALIDATION_ERRORS do |e|
      error!({ error: "AI Validation: #{e}", code: 422, reason: e.class.to_s }, 422)
    end

    rescue_from *FATAL_VALIDATION_ERRORS do |e|
      ::Loggers::Validations.logger.info e.message
      error!({ error: "Fatal params error: #{e.message}", code: 422, reason: e.class.to_s }, 422)
    end

    rescue_from *AUTHENTICATION_ERRORS do |e|
      error!({ error: 'Unauthenticated', reason: e.class.to_s, code: 401 }, 401)
    end

    # rescue_from *AUTHORIZATION_ERRORS do |e|
    #   error!({
    #            error: 'Resource or action is forbidden!',
    #            reason: e.class.to_s, code: 403
    #          }, 403)
    # end

    rescue_from ActiveRecord::RecordNotFound do |e|
      message = Rails.env.development? ? "Resource not found: #{e.message}" : 'Resource not found'
      error!({ error: message, code: 404, reason: e.class.to_s }, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      # error_code = ::API::IpStats::Exceptions::Details.fetch_invalid_record_code(e.record)
      error_code = nil

      error!({
        error: "Invalid Resource: #{e.message}",
        code: error_code, reason: e.class.to_s
      }, 422)
    end

    rescue_from ActiveRecord::StatementInvalid do |e|
      error!({ error: "Invalid Resource: #{e.message}", reason: e.class.to_s }, 422)
    end

    rescue_from JSON::ParserError do
      error!({ error: "Invalid JSON value: #{e.message}", code: 422 }, 422)
    end

    rescue_from ::API::IpStats::Exceptions::RouteApiPointNotFoundError do |e|
      error!({
               error: e.message,
               code: 500, reason: e.class.to_s
             }, 500)
    end

    rescue_from ArgumentError do |e|
      error!({
               error: "ArgumentError: #{e.message}",
               code: 422, reason: e.class.to_s
             }, 422)
    end

    # Delegate other exceptions to Bugsnag
    rescue_from :all do |e|
      if Rails.env.development?
        # error!({ error: "Fatal error: #{e.message}", code: 500, reason: e.class.to_s }, 500)
        raise e
      else
        Rails.logger.error({
          message: e.message,
          code: 500,
          exception: e.backtrace
        })
        # Bugsnag.notify(e)

        error!({
          error: 'Fatal error!',
          code: 500,
          reason: "#{e.class.to_s}: Please send the current report to developers."
        }, 500)
      end
    end
  end
end