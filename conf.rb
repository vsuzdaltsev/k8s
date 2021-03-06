#!/usr/bin/env ruby
# NB: comment 'network_mode' attribute from docker-compose.yml if running on MAC

module WebApiConf
  module_function

  def where_gemfile
    `find $PWD -name '*Gemfile'`.chomp
  end

  def ruby_ver
    File.readlines(where_gemfile).grep(/ruby /).join.split[1]
  end

  DEFAULTS = {
    future: 'no future',
    valid_http_methods: %w[
      delete
      get
      patch
      post
      put
    ],
    api_url_base_v1: '/api/v1'
  }.freeze
  DOCKER = {
    env_file:     '.env'
  }.freeze
  UNICORN = {
    working_dir:    '/opt/app',
    ruby_ver:       ruby_ver,
    host:           '0.0.0.0',
    port:           '4567',
    timeout:        '5',
    workers:        '2',
    log_vol:        '/var/log/:/opt/app/web_api/log',
    container_name: 'unicorn'
  }.freeze
end
