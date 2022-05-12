require "uri"
require "net/http"
require "json"
def request(url_request)

    url = URI(url_request)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    result = JSON.parse(response.read_body)
    #puts response.read_body
end

request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY")