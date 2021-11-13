# frozen_string_literal: true

GrapeSwaggerRails.options.app_name = 'IpStats API'
GrapeSwaggerRails.options.url      = '/api/ip_stats/v1/docs.json'
GrapeSwaggerRails.options.before_action do
  # GrapeSwaggerRails.options.app_url = "#{request.protocol}#{request.host_with_port}"
  # GrapeSwaggerRails.options.app_url = Settings.swagger.host
  GrapeSwaggerRails.options.app_url = 'http://localhost:3000'
end
# GrapeSwaggerRails.options.api_auth     = 'bearer'
# GrapeSwaggerRails.options.api_auth     = 'basic'
# GrapeSwaggerRails.options.api_key_name = 'X-Session-Token'
# GrapeSwaggerRails.options.api_key_type = 'header'
