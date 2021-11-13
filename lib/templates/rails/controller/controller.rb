# frozen_string_literal: true

<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
# frozen_string_literal: true

class <%= class_name %>Controller < ApplicationController
  ## Modules, constants
  ## Helpers
  ## Before, after and other filters
  ## Loading and authorize resource(s)
  ## Decorate resource(s)
  ## Responders

  ## Actions
<% actions.each do |action| -%>
  def <%= action %>
  end
<%= "\n" unless action == actions.last -%>
<% end -%>

  ## Protected methods
  ## Callbacks before, after, other filters and etc
  protected

  ## Private methods
  ## Callbacks before, after, other filters and etc
  private
end
<% end -%>
