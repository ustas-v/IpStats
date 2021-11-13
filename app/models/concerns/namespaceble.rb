# frozen_string_literal: true

# Rails doesn't handle namespacing tables by default. This concern solves for that by setting the
# including models' table name to the underscore-case of the full path
#
# e.g. Profiles::User => profiles_user
module Namespaceble
  extend ActiveSupport::Concern

  included do
    def self.table_name
      # If a table_name_prefix has been defined, follow default behaviour
      return super if full_table_name_prefix.present?

      prefix = model_name.to_s.deconstantize.underscore.gsub('/', '_')

      # If we have a prefix and it is different - we add
      # Otherwise we return the default
      # (In the case of STI - the prefix will be equal - so we don't add anything)
      if prefix.present? && prefix != super
        # Otherwise add the prefix with an underscore
        "#{prefix}_#{super}"
      else
        super
      end
    end
  end
end
