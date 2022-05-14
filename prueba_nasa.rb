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
    #print result
    #puts response.read_body
end

def build_web_page(principal)
    photos = principal['photos']
    url_photo = photos.map{|x| x['img_src']}
    #print url_photo
    html = ""
    html += "<html>\n<head>\n<title></title>\n</head>\n<body>\n<ul>\n"
    url_photo.each do |photo|
        html += "   <li><img src=\"#{photo}\" width='300' height='200'></li>\n" 
    end
    html += "</ul>\n</body>\n</html>"
    File.write('index.html', html)
  

end


principal = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DCQZgXMlvJjgCGJi8oWMtsotSEvs9PP8egenN3NN")
build_web_page(principal)

    
    



  

#  contents = <<~HTML
#     <html>
#       <head>
#       </head>
#       <body>
#       <ul>
#          <li>
        
#       </ul>
#       </body>
#     </html>
#   HTML

#   File.write("index.html", contents)
