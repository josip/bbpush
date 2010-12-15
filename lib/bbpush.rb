$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

%w(net/http net/https uri base64).each { |l| require l}
require 'bbpush/client.rb'

module BBPush
  VERSION = "0.1.0"
end