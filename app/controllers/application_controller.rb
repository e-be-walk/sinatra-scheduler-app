require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

helpers do
  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  def user_id
    current_user.id
  end
end
end
