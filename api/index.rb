require "uri"
require 'net/http'

def munge_feed(feed_body)
  feed_body.gsub(/((DTSTART|DTEND);VALUE=DATE-TIME:\d{8}T)080000Z/, "\\1000000")
    .gsub(/((DTSTART|DTEND);VALUE=DATE-TIME:\d{8}T)090000Z/, "\\1000000")
end

def get_feed(user_id, team_id)
  url = "https://indeed-ops.pagerduty.com/private/#{ user_id }/feed#{ team_id ? "/#{team_id}" : "" }"
  uri = URI(url)

  Net::HTTP.get_response(uri)
end

Handler = Proc.new do |request, response|
  user_id = request.query['user_id']
  team_id = request.query['team_id'] || nil
  feed_response = get_feed(user_id, team_id )

  new_body = munge_feed(feed_response.body)

  response.status = 200
  response.body = new_body

  # Add the magic calendar headers
  feed_response.to_hash.each do |header, value|
    next unless ["content-type", "content-disposition"].include?(header)
    response[header] = value.first
  end
end
