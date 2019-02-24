require 'webrick'

include WEBrick

port = ENV['PORT']
user = ENV['USER']
pass = ENV['PASS']

server = HTTPServer.new(
  :Port => port,
  :DocumentRoot => './',
  :RequestCallback => lambda do |req, res|
    HTTPAuth.basic_auth(req, res, "my realm") do |username, password|
      username == user && password == pass
    end
  end
)

trap("INT"){ server.shutdown }
server.start
