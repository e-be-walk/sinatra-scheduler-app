class TodosController < ApplicationController

  get '/todos' do
    @todos = Todo.all
    erb :'/todos/show_todos'
  end

  get '/todos/new' do
    erb :'/todos/create_new'
  end

  get '/todos/edit' do
    erb :'/todos/edit'
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
    @todo = Todo.find(params[:todo])
    if params["todo"]["name"].empty? || checkbox.empty?
      redirect "/todos/new"
    else
      @todo.update(params[:todo])
      @todo.save
      erb :'/todos/show_todos'
    end
  end


end
