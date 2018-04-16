class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    if logged_in?
      erb :'/users/show'
      #redirect '/users/:slug'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:id] = @user.id
      redirect to "/users/#{@user.username}"
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/appointments'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    #binding.pry
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/users/#{@user.username}"
      #redirect "/appointments"
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
