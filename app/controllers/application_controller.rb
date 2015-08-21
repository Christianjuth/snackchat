# Set environment
require "./config/environment"

# Get models
require "./app/models/user"
require "./app/models/snack"

# Set routs
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
  end

  # Home page
  get "/" do
    @all_snacks = Snack.all
    erb :index
  end


  # Sign up
  get "/sign_up" do
    erb :sign_up
  end

  post "/sign_up" do
    user = User.new({
      username: params[:username],
      email:    params[:email]
    })
    user.save
    redirect '/'
  end


  # User page
  get "/user/:username" do
    username = params[:username]
    @my_snacks = Snack.where(receiver: username)
    erb :user
  end

  # Snack page
  get "/snack/:id" do
    id = params[:id]
    @snack = Snack.where(id: id)[0]
    if @snack.nil?
      redirect "/"
    else
      erb :snack
    end
  end


  # send
  get "/send_snack" do
    erb :send_snack
  end

  # send snacks
  post '/send_snack' do
    snack = Snack.new({
      username: params[:username],
      snack: params[:snack],
      receiver: params[:receiver],
      timestamp: params[:timestamp]
    })
    snack.save
    redirect "/"
  end
end
  