require_relative 'api/index'
require "ostruct"

request = OpenStruct.new(
  query: {
    "user_id" => "4b479779ab3dede3b64abdece2c04e74cf8d6ee46d9bc7b4ea4eb6afdd083b0d",
    # "team_id" => "PT6YONJ"
  }
)

response = OpenStruct.new()

Handler.call(request, response)

puts response.inspect