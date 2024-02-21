require 'sinatra'
require 'sinatra/reloader' if development?

# Mock data to simulate API responses
CURRENCIES = {
  "USD" => "United States Dollar",
  "EUR" => "Euro",
  "JPY" => "Japanese Yen",
  "GBP" => "British Pound Sterling"
}.freeze

CONVERSION_RATES = {
  "USD_EUR" => 0.85,
  "EUR_USD" => 1.18,
  # Add mock rates for demonstration
}.freeze

get '/' do
  @currencies = CURRENCIES
  erb :index
end

get '/:currency_symbol' do
  @currency_symbol = params[:currency_symbol].upcase
  @currencies = CURRENCIES.except(@currency_symbol)
  erb :currency
end

get '/:from_currency/:to_currency' do
  @from_currency = params[:from_currency].upcase
  @to_currency = params[:to_currency].upcase
  rate_key = "#{@from_currency}_#{@to_currency}"
  @rate = CONVERSION_RATES[rate_key] || "N/A"
  erb :conversion
end

not_found do
  erb :error, locals: { error_message: "The requested resource was not found." }
end

error 500 do
  erb :error, locals: { error_message: "Internal server error." }
end
