# frozen_string_literal: true

class Workers::Base
  include Sidekiq::Worker

  # For unqiue jobs
  def self.lock(id)
    "locks:unique:#{id}"
  end

  # For unqiue jobs
  def self.unlock!(id)
    lock = self.lock(id)
    Sidekiq.redis { |connection| connection.del(lock) }
  end
end
