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
	do_search @query if @query
	erb :index
end


def do_search(q)
	response = api.search(q)
	if response.code == 200
		# logger.info "Response: #{response.body}"
		@beers = parse_beers(response)
	else
		logger.error = "ERROR: #{response.body}"
		@error = response.body
	end
end

def parse_beers(response)
	return [] unless response["data"]

	response["data"].map { |beer_json|
		Beer.from_json(beer_json)
		logger.info Beer
	}
end

def api
	@api ||= Brewerydb.new(ENV['BREWERYDB_API_KEY'])
end