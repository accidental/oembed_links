require 'net/http'

class OEmbed
  module Fetchers
    class NetHTTP
      
      def name
        "NetHTTP"
      end

      def fetch(url,redirected=0)
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        http.use_ssl = true if url =~ /^https/
        response = http.request(request)
        
        case response
        #when Net::HTTPSuccess then
        #  response.body
        when Net::HTTPRedirection then
          if redirected > 10
            # too many redirects, fail silently
            ''
          else
            fetch(response['location'], redirected + 1)
          end
        else
          response.body
        end
      end
      
    end
  end
end

OEmbed.register_fetcher(OEmbed::Fetchers::NetHTTP)
