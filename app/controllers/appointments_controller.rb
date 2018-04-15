class AppointmentsController < ApplicationController

  get '/appointments/new' do
    if !logged_in?
      redirect '/login'
    end
    erb :'/appointments/create_appointment'
  end

  get '/appointments' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      erb :'/appointments/appointments'
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

  delete '/tweets/:id/delete' do
    @appointment = Appointment.find(params[:id])
    if @appointment.id == current_user.id
      @appointment.delete
    end
  end
end
