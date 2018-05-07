class AppointmentsController < ApplicationController

  get '/appointments' do
    if logged_in?
      @appointments = Appointment.all.sort_by {|appointment| appointment.datetime}
      erb :'/appointments/appointments'
    else
      redirect to '/login'
    end
  end

  get '/appointments/new' do
    if logged_in?
      erb :'appointments/create_new'
    else
      redirect to '/login'
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
    erb :'/appointments/show_appointment'
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
    @appointment = Appointment.find_by_id(params[:id])
    if logged_in?
      @appointment = Appointment.find_by_id(params[:id])
      if @appointment.user_id == session[:user_id]
        @appointment.delete
        redirect to '/'
      else
        redirect to '/'
      end
    else
      redirect to '/login'
    end
  end
end
