class UsersController < ApplicationController

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
      flash[:message] = "Please fill out each field"
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

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/"
    else
      flash[:message] = "We don't have that info. Want to sign up?"
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/'
    end
  end

end
