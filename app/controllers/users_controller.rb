class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.new(params)

    if @user.username == "" || @user.email = ""
      redirect '/signup'
    elsif @user.save
      session[:id] = user.id
      redirect '/scheduler'
    else
      redirect '/signup'
    end
  end
  
end
