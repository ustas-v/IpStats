# frozen_string_literal: true

require 'rails_helper'

<% module_namespacing do -%>
describe <%= class_name %>, type: :model do
  pending "some examples to (or delete) #{__FILE__}"

  # Lazily loaded to ensure it's only used when it's needed
  # RSpec tip: Try to avoid @instance_variables if possible. They're slow.

  # let(:factory_instance) { create(:factory_name) }

  describe 'ActiveRecord associations' do
    # Describe associations model
  end

  describe 'ActiveModel validations' do
    # Describe validations model
  end

  describe 'Database structure' do
    # Describe database structure of model
  end

  describe 'Callbacks' do
    # Describe callbacks model
  end

  describe 'Scopes' do
    # Describe scopes model
  end

  describe 'Public instance methods' do
    # Describe public instance methods
  end

  describe 'Public class methods' do
    # Describe public class methods
  end

  describe 'Business logic' do
    # Describe other business logic
  end
end
<% end -%>
