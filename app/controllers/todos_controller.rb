class TodosController < ApplicationController

  get '/todos' do
    @user = current_user
    erb :'/todos/show_todos'
  end

  get '/todos/new' do
    erb :'/todos/create_new'
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

  get '/todos/:id/edit' do
    if !logged_in?
      redirect '/'
    else
      @todo = Todo.find(params[:id])
      erb :'/todos/edit'
    end
  end

  patch '/todos/:id' do
    @todo = Todo.find(params[:id])
    @todo.update(params[:todo])
    @todo.save
    erb :'/todos/show_todos'
  end

  delete '/todos/:id/delete' do
    @todo = Todo.find_by_id(params[:id])
    if logged_in?
      @todo = Todo.find_by_id(params[:id])
      @todo.delete
      redirect to '/'
    else
      redirect to '/login'
    end
  end
end
