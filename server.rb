require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?

set :public_folder, File.join(File.dirname(__FILE__), 'public')

get '/' do
	@query = params[:q]
	erb :index
end