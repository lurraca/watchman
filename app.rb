require 'sinatra'
require 'json'
require './lib/watchman'

get '/start' do
  watchman = Watchman.new(logger: logger)
  watchman.run_experiment
  "Running experiment"
end
