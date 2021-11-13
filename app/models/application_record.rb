# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include ::Arelable

  self.abstract_class = true
end
