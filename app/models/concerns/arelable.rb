# frozen_string_literal: true

# Use A Relational Algebra

module Arelable
  extend ActiveSupport::Concern

  included do
    scope :greater_than, -> (hash) do
      field, value = hash.first
      where(table[field].gt(value))
    end

    scope :less_than, -> (hash) do
      field, value = hash.first
      where(table[field].lt(value))
    end

    scope :greater_eql, -> (hash) do
      field, value = hash.first
      where(table[field].gteq(value))
    end

    scope :less_eql, -> (hash) do
      field, value = hash.first
      where(table[field].lteq(value))
    end
  end

  module ClassMethods
    # Use A Relational Algebra
    def table
      arel_table
    end
  end

  protected

  def table
    self.class.table
  end
end
