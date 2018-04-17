class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    #binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/"
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
