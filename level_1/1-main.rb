#!/usr/bin/ruby
require 'uri'
require 'net/http'
require 'nokogiri'

HolbertonId = 1201
votes_to_reach = 4096
current_votes = 0
ref = "http://158.69.76.135/level1.php"

url = URI(ref)

# LOAD DOCUMENT
while (current_votes < (votes_to_reach - 1))
  puts "Begin process."
  Net::HTTP.start(url.host, url.port) do |http|
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    cookies = response.response['set-cookie'] 
    doc = Nokogiri::HTML(response.body)
    key = doc.at('input[@name="key"]')['value'].to_s
    # GET CURRENT VOTES
    table = doc.at('table')
    table.search('tr').each do |tr|
        cells = tr.search('th, td')
        if cells[0].text.to_i == HolbertonId
        current_votes = cells[1].text.to_i
        puts "-> Found id "+HolbertonId.to_s+" has "+current_votes.to_s+"/"+votes_to_reach.to_s+" votes."
        # PUTS A NEW VOTE
        if current_votes < votes_to_reach
          post = Net::HTTP::Post.new(url)
          post['Cookie'] = cookies
          post["content-type"] = 'application/x-www-form-urlencoded'
          post.body = "id="+HolbertonId.to_s+"&key="+key+"&holdthedoor=Enviar"
          res_post = http.request(post)
          puts "-> New vote to "+HolbertonId.to_s+" has made."
        else
          puts "-> Can't send another vote."
        end
        break
        end
    end
  end
end
puts "-> Reach the limit of "+votes_to_reach.to_s+" votes."
puts "Process terminated."
