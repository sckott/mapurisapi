require 'rubygems'
require 'bundler'

Bundler.require

disable :run, :reload

require './mapurisapi'

run Sinatra::Application
