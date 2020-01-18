#!/usr/bin/ruby
require 'uri'
require 'net/http'
require 'nokogiri'

HolbertonId = 1201
votes_to_reach = 1024
current_votes = 0


url = URI("http://158.69.76.135/level0.php")

# LOAD DOCUMENT
while (current_votes < (votes_to_reach - 1))
  puts "Begin process."
  http = Net::HTTP.new(url.host, url.port)
  request = Net::HTTP::Get.new(url)
  response = http.request(request)
  doc = Nokogiri::HTML(response.read_body)
  # GET CURRENT VOTES
  table = doc.at('table')
  table.search('tr').each do |tr|
    cells = tr.search('th, td')
    if cells.text.to_i == HolbertonId
      current_votes = cells[1].text.to_i
      puts "-> Found id "+HolbertonId.to_s+" has "+current_votes.to_s+"/"+votes_to_reach.to_s+" votes."
      # PUTS A NEW VOTE
      if current_votes < votes_to_reach
        vote_request = Net::HTTP::Post.new(url)
        vote_request["content-type"] = 'application/x-www-form-urlencoded'
        vote_request.body = "id="+HolbertonId.to_s+"&holdthedoor=Enviar"
        response_vote = http.request(vote_request)
        puts "-> New vote to "+HolbertonId.to_s+" has made."
      else
        puts "-> Can't send another vote."
      end
      break
    end
  end
end
puts "-> Reach the limit of "+votes_to_reach.to_s+" votes."
puts "Process terminated."
