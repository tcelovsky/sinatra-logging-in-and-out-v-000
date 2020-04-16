require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/") }
    
  configure do  
    enable :sessions 
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    # binding.pry
    user = User.find_by(username: params[:username])
    if user 
    session[:user_id] = user.id
    redirect to :'/account'
    elsif redirect to :'/'
    end
  end

  get '/account' do
    if User.is_logged_in?
      erb :account
    elsif redirect to :'/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to :'/'
  end


end

