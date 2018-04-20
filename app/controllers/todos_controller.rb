class TodosController < ApplicationController

  get '/todos' do
    @todos = Todo.all
    erb :'/todos/show_todos'
  end

  get 'todos/new' do
    erb :'/todos/create_new'
  end

  post '/todos' do
    if !params[:todo][:content].empty?
      @todo = Todo.create(params[:todo])
      @todo.user_id = current_user.id
      @todo.save
      erb :'/todos/show_todos'
    else
      redirect '/todos/new'
    end
  end


end
