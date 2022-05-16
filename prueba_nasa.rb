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
    html += "<html>\n<head>\n<title></title>\n</head>\n<body>\n   <ul>\n"
    url_photo[0..9].each do |photo|
        html += "     <li><img src=\"#{photo}\"></li>\n" 
    end
    html += "   </ul>\n</body>\n</html>"
    File.write('index.html', html)

end

def cont_photos(principal)
    contador = {}
    principal["photos"].each do |camera_name|
        camera_name["camera"].each do |key,value|
            if 
                key == "name"
                if
                    contador.include? value
                    contador[value] += 1
                else
                    contador[value] = 1
                end
            end
        end
    end
    contador
end


principal = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DCQZgXMlvJjgCGJi8oWMtsotSEvs9PP8egenN3NN")
build_web_page(principal)
cont_photos(principal)
    
    





