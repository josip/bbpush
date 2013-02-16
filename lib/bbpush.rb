$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'uri'
require 'faraday'
require 'bbpush/client.rb'

module BBPush
  VERSION = "0.2.0"
end