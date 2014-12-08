require 'rubygems'
require 'sinatra'
require 'httparty'
require 'json'

url = 'http://localhost:9200/mapuris/uris'
# url = 'http://localhost:5984/mapuris'
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

get '/search' do
	url2 = url + '/_search'
	options = {
		query: {
			q: params[:q]
		}
	}
	res = HTTParty.get(url2, options)
	body = JSON.parse(res.body)
	body['hits']['hits'] = body['hits']['hits'].collect { |p| {"score" => p['_score'], "source" => p['_source'] } }
	out = { "status" => "ok", "data" => body['hits'] }
	return JSON.pretty_generate(out)
end
