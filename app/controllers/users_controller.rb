class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/users/show'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/scheduler'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(params[:user])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/scheduler'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
end
