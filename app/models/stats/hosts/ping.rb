# frozen_string_literal: true

# == Schema Information
#
# Table name: stats_hosts_pings
#
#  id                  :bigint           not null
#  host_id             :bigint           not null
#  rtt                 :decimal(8, 3)
#  mdev                :decimal(8, 3)
#  packet_loss_percent :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Stats::Hosts::Ping < ApplicationRecord
  ## Modules, constants, attr_*

  include ::Namespaceble

  ## Associations, delegates

  belongs_to :host, class_name: '::Host'

  ## Validations
  ## Callbacks
  ## Scopes

  scope :by_datetime, -> (datetime) { where(created_at: datetime) }

  ## Other meta methods

  ## Protected methods
  ## Callbacks and etc.
  protected

  ## Private methods
  ## Callbacks and etc.
  private
end
