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
    Tweet.new("jim", "Hello I'm a Steelers fan!")
    Tweet.new("christian", "Pizza!")
    Tweet.new("nick", "I love Vim")
    Tweet.new("nick", "I love Vim")
    Tweet.new("pickle", "Yoooodllllayyyyyeeee")
    @all_tweets = Tweet.all
    erb :index
  end

  # Post to Fwitter
POST '/tweet' do
    tweet = Tweet.new({:user => params[:user], :status => params[:status]})
    tweet.save
    redirect ‘/tweets’
  end
end
