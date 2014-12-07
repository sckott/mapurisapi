require 'rubygems'
require 'sinatra'
require 'HTTParty'
require 'json'

url = 'http://localhost:5984/mapuris'

before do
  puts '[Params]'
  p params
end

before do
  headers "Content-Type" => "application/json; charset=utf8"
end

get '/' do
	{ "message" => 'Hello world!' }.to_json
end

get "/heartbeat" do
	{ "status" => "ok" }.to_json
end

get '/links/*' do
	puts params[:splat]
	doi = params[:splat].first
	doi = doi.sub("/", "%2F")
	url2 = url + '/' + doi
	res = HTTParty.get(url2)
	return JSON.pretty_generate(res.to_s)
end
