require 'rubygems'
require 'bundler/setup'
Bundler.require
require 'sinatra'
require 'sinatra/reloader' if development?
Dotenv.load

require_relative './app/services/brewerydb'
require_relative './app/models/beer'

set :public_folder, File.join(File.dirname(__FILE__), 'public')

get '/' do
	@query = params[:q]
	erb :index
end

def api
	@api ||= Brewerydb.new(ENV['BREWERYDB_API_KEY'])
end