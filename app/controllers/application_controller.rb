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
    enable :sessions
    set :session_secret, "carson"
  end

  before do
    if (!session[:user_id] || !User.exists?(session[:user_id]) ) && !["/login","/signup"].include?(request.path)
      redirect "/login"
    elsif !["/login","/signup"].include?(request.path)
      @user = User.find(session[:user_id])
    end
  end

  # Home page
  get "/" do
    @my_snacks = Snack.where(receiver_id: session[:user_id])
    erb :index
  end


  # Log in
  get "/login" do
    erb :login
  end

  post "/login" do
    @user = User.find_by({:username => params[:username]})
    if @user
      session[:user_id] = @user.id
      case request_type?
      when :ajax
        body({
          success: true, 
          message: "success",
          redirect: "/"
        }.to_json)
      else 
        redirect "/"
      end
    else
      case request_type?
      when :ajax
        status 500
        body({
          success: false, 
          message: "Incorrect username or password"
        }.to_json)
      else 
        redirect "/login"
      end
    end
  end
  
  #logout
  post "/logout" do
    session.destroy
    redirect "/login"
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


  # Sign up
  get "/signup" do
    erb :signup
  end

  post "/signup" do
    @user = User.create({
      username: params[:username],
      email:    params[:email]
    })
    if @user
      session[:user_id] = @user.id
      case request_type?
      when :ajax
        body({
          success: true, 
          message: "success",
          redirect: "/"
        }.to_json)
      else 
        redirect "/"
      end
    else
      case request_type?
      when :ajax
        status 500
        body({
          success: false, 
          message: "Incorrect username or password"
        }.to_json)
      else 
        redirect "/login"
      end
    end
    redirect '/'
  end


  # send
  get "/send_snack" do
    erb :send_snack
  end

  # send snacks
  post '/send_snack' do
    snack = Snack.new({
      user_id: session[:user_id],
      snack: params[:snack],
      receiver_id: params[:receiver]
    })
    snack.save
    redirect "/"
  end


  # Helpers
  def error_messages_for(object)
    all_errors = ""
    for error in object.errors.messages do
      key = error.first.to_s.capitalize
      what_is_wrong = error.second.join(' and ')
      all_errors += "#{key} #{what_is_wrong}.\n"
    end
    all_errors
  end

  def request_type?
    return :ajax    if request.xhr?
    return :normal
  end
end
  