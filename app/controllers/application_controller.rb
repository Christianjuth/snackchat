# Set environment
require "./config/environment"

# Get models
require "./app/models/tweet"

# Set routs
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
  end

  # Home page
  get "/" do
    @all_tweets = Snack.all
    erb :index
  end

  # Post to Fwitter
  post '/new_tweet' do
    Tweet.new(params["username"], params["msg"])
    @all_tweets = Tweet.all
    erb :index
  end
end
