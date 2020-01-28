#!/usr/bin/env ruby
# frozen_string_literal: true

require File.expand_path('spec_helper.rb', __dir__)
include Rack::Test::Methods

def app
  RestApi
end

describe 'post_create_future_route' do
  context 'when curl post_create_future' do
    it 'should successfully return default response from the route' do
      post "#{WebApiConf::DEFAULTS[:api_url_base_v1]}/post_create_future"
      expect(last_response).to be_ok
      expect(last_response.body).to match '{"method_name":"POST /api/v1/post_create_future","future":"no future"}'
    end
  end
end

describe 'create_default_route_methods' do
  context 'when curl different http types' do
    it 'should successfully return default response from default route with http type' do
      container = `hostname`.chomp
      WebApiConf::DEFAULTS[:valid_http_methods].each do |method|
        send(method, "#{WebApiConf::DEFAULTS[:api_url_base_v1]}/*") do
          expect(last_response).to be_ok
          expect(last_response.body).to match "{\"help\":\"#{method} method default route\",\"executed_on\":\"#{container}\",\"kubernetes_namespace\":null}"
        end
      end
    end
  end
end
