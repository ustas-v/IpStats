# frozen_string_literal: true

module API::IpStats::Exceptions
  class AccessDenied                < StandardError; end
  class InvalidSessionToken         < StandardError; end
  class ExpiredSessionToken         < StandardError; end
  class EmptySessionToken           < StandardError; end
  class AuthenticationError         < StandardError; end
  class DestroyRecordInUseError     < StandardError; end
  class RouteApiPointNotFoundError  < StandardError; end
  class FailedDependencyError       < StandardError; end

  class OtherTokenInvalidError < StandardError
    attr_reader :status

    def initialize(message, status)
      super(message)
      @status = status
    end
  end
end
