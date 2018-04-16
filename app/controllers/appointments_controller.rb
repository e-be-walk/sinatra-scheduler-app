class AppointmentsController < ApplicationController

  get '/appointments/new' do
    if !logged_in?
      redirect '/login'
    end
    erb :'/appointments/create_new'
  end

  get '/appointments' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      redirect to "/users/#{@user.username}"
      #erb :'/appointments/appointments'
    end
  end

  post '/appointments' do
    if !params[:appointment][:content].empty?
      @appointment = Appointment.create(params[:appointment])
      @appointment.user_id = current_user.id
      @appointment.save
      erb :'/appointments/show_appointment'
    else
      redirect '/appointments/new'
    end
  end

  get '/appointments/:id' do
    if !logged_in?
      redirect '/login'
    end
    @appointment = Appointment.find(params[:id])
    erb :'/appointment/show_appointment'
  end

  get '/appointments/:id/edit' do
    if !logged_in?
      redirect '/login'
    end
    @appointment = Appointment.find(params[:id])
    erb :'/appointments/edit_appointment'
  end

  patch '/appointments/:id' do
    @appointment = Appointment.find(params[:id])
    if params[:appointment][:content].empty?
      redirect "/appointments/#{@appointment.id}/edit"
    else
      @appointment.update(params[:appointment])
      @appointment.save
      redirect "/appointments/#{@appointment.id}"
    end
  end

  delete '/appointments/:id/delete' do
    @appointment = Appointment.find(params[:id])
    if @appointment.id == current_user.id
      @appointment.delete
    end
  end
end
