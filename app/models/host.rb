# frozen_string_literal: true

# == Schema Information
#
# Table name: hosts
#
#  id         :bigint           not null, primary key
#  ip_address :inet             not null
#  state      :integer          default("active"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_hosts_on_ip_address  (ip_address) UNIQUE
#

class Host < ApplicationRecord
  ## Modules, constants, attr_*

  enum state: {
    active:   0,
    inactive: 1
  }, _prefix: true

  ## Associations, delegates

  has_many :ping_stats, class_name: '::Stats::Hosts::Ping'

  ## Validations

  validates :ip_address, presence: true, uniqueness: true

  ## Callbacks

  after_save :run_stats_ping_collector

  ## Scopes

  scope :by_ip_address, -> (ip) { where(ip_address: ip) }

  ## Other meta methods

  ## Protected methods
  ## Callbacks and etc.
  protected

  ## Private methods
  ## Callbacks and etc.
  private

  def run_stats_ping_collector
    ::Workers::Stats::Hosts::PingCollector.perform_async(id) if state_active?
  end
end
