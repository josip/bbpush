module BBPush
  class Client
    BOUNDARY = "hibbfolks34thj"

    attr_accessor :app_id, :password, :push_server_url
    
    def initialize(options={})
      @app_id = options[:app_id]
      @password = options[:password]
      @push_server_url = options[:push_server_url] || "https://pushapi.eval.blackberry.com/mss/PD_pushRequest"
    end
    
    def send_notification(bb_pins, message, deliver_within)
      conn = Faraday.new(:url => self.push_server_url,
                         :ssl => {:verify => false})
      conn.basic_auth(self.app_id, self.password)

      conn.post do |req|
        req.headers['User-Agent'] = "BBPush.rb/#{BBPush::VERSION}"
        req.headers['Content-Type'] = "multipart/related; boundary=#{BBPush::Client::BOUNDARY}; type=application/xml"
        
        push_id = ((Time.now.to_i * rand) + Time.now.to_i).round
      
        addresses = []
        bb_pins.each do |a|
          addresses << "<address address-value=\"#{a}\"/>\n"
        end
        
        data = <<-BBPUSH
--#{BBPush::Client::BOUNDARY}
Content-Type: application/xml; charset=UTF-8

<?xml version="1.0"?>
<!DOCTYPE pap PUBLIC "-//WAPFORUM//DTD PAP 2.1//EN" "http://www.openmobilealliance.org/tech/DTD/pap_2.1.dtd">
<pap><push-message push-id="#{push_id}" deliver-before-timestamp="#{(Time.now.utc + (deliver_within * 60)).strftime("%Y-%m-%dT%H:%M:%S")}Z" source-reference="#{self.app_id}">
#{addresses.join("\n")}<quality-of-service delivery-method="unconfirmed"/></push-message></pap>
--#{BBPush::Client::BOUNDARY}
Content-Type: text/plain

#{message}
--#{BBPush::Client::BOUNDARY}
BBPUSH
        req.body = data.gsub(/\n/,"\r\n")
      end
    end
  end
end
