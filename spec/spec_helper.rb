require 'rubygems'
require 'bundler/setup'

require 'facepost' # and any other gems you need
require 'webmock/rspec'

RSpec.configure do |config|
   config.mock_with :rspec
end

WebMock.disable_net_connect!