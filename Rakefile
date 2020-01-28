#!/usr/bin/env ruby
# frozen_string_literal: true

load                   'conf.rb'

RUBY_VER               = WebApiConf::UNICORN[:ruby_ver]
APP_DIR                = WebApiConf::UNICORN[:working_dir]
UNICORN_CONTAINER_NAME = WebApiConf::UNICORN[:container_name]
UNICORN_HOST           = WebApiConf::UNICORN[:host]
UNICORN_PORT           = WebApiConf::UNICORN[:port]
UNICORN_TIMEOUT        = WebApiConf::UNICORN[:timeout]
UNICORN_WORKERS        = WebApiConf::UNICORN[:workers]
DOCKER_ENV_FILE        = WebApiConf::DOCKER[:env_file]

task :default do
  puts "* Type 'rake --tasks' to list existent tasks"
end

namespace :docker_compose do
  task :create_env do
    puts "* Delete env file #{DOCKER_ENV_FILE}"
    system("truncate -s 0 #{DOCKER_ENV_FILE}")
    puts "* Create env file #{DOCKER_ENV_FILE}"
    system(
      "(echo APP_DIR=#{APP_DIR}
      echo RUBY_VER=#{RUBY_VER}
      echo UNICORN_PORT=#{UNICORN_PORT}
      echo UNICORN_HOST=#{UNICORN_HOST}
      echo UNICORN_TIMEOUT=#{UNICORN_TIMEOUT}
      echo UNICORN_WORKERS=#{UNICORN_WORKERS}
      echo UNICORN_CONTAINER_NAME=#{UNICORN_CONTAINER_NAME}) > #{DOCKER_ENV_FILE}"
    )
  end

  desc 'build service'
  task :build do |t|
    Rake::Task["#{t.scope.path}:create_env"].execute
    puts '* Run docker-compose build'
    system('docker-compose build')
  end

  desc 'run service'
  task :run do |t|
    Rake::Task["#{t.scope.path}:create_env"].execute
    system('docker-compose up -d')
  end

  desc 'stop service'
  task :stop do |t|
    Rake::Task["#{t.scope.path}:create_env"].execute
    system('docker-compose stop')
    system('docker-compose rm -f')
    system('rm -f .env')
  end
end

# namespace :test do
#  desc 'rspec'
#  task :rspec do |t|
#    system('rspec .')
#  end
# end
