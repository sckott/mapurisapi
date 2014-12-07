require 'rubygems'
require 'sinatra'
require 'httparty'
require 'json'

url = 'http://localhost:5984/mapuris'
# url = 'https://app16517180.heroku.cloudant.com/mapuris'

# before do
#   puts '[Params]'
#   p params
# end

before do
  headers "Content-Type" => "application/json; charset=utf8"
end

get '/' do
	redirect '/heartbeat'
end

get "/heartbeat" do
	return JSON.pretty_generate({ "status" => "ok" })
end

get '/links/*' do
	doi = params[:splat].first
	doi = doi.sub("/", "%2F")
	url2 = url + '/' + doi
	res = HTTParty.get(url2)
	body = JSON.parse(res.body)
	out = { "status" => "ok", "data" => body }
	return JSON.pretty_generate(out)
end
