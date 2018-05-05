class TodosController < ApplicationController

  get '/todos' do
    @todos = Todo.all
    erb :'/todos/show_todos'
  end

  get '/todos/new' do
    erb :'/todos/create_new'
  end

  get '/todos/edit' do
    if !logged_in?
      redirect '/'
    else
      @user = current_user
      erb :'/todos/edit'
    end
  end

  post '/todos' do
    @todo = Todo.create(params[:todo])
    #binding.pry
    if !params["todo"]["name"].empty?
      @todo = Todo.create(params[:todo])
      @todo.user_id = current_user.id
      @todo.save
      erb :'/todos/show_todos'
    else
      redirect '/todos/new'
    end
  end

  patch '/todos' do
    @todo = Todo.find_by(params[:id])
    if params["todo"]["name"].empty?
      redirect "/todos/new"
    else
      @todo.update(params[:todo])
      @todo.save
      erb :'/todos/show_todos'
    end
  end

  delete '/todos/delete' do
    @todo = Todo.find_by(params[:user_id])

    if @todo.id == current_user.id
    @todo.delete
    #binding.pry
  end
    redirect "/todos"
  end
end
