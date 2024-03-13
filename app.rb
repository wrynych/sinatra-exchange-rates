# /app.rb
require "sinatra"
require "sinatra/reloader"
require "http"

# define a route
get("/") do

  # build the API url, including the API key in the query string
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATES_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)
  # get the symbols from the JSON
  # @symbols = parsed_data ...

  # render a view template where I show the symbols
  # erb(:homepage)
end
end

# Define a route to handle requests for currency pairs
get '/:currency' do
  @base_currency = params[:currency]
  erb :currency
end

# Define a route to handle requests for individual currency conversion
get '/:base_currency/:target_currency' do
  @base_currency = params[:base_currency]
  @target_currency = params[:target_currency]
  erb :conversion
end
