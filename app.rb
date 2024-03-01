require 'sinatra'

# Define a route for the home page
get '/' do
  erb :index
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

