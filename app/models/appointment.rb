class Appointment < ActiveRecord::Base
  belongs_to :user

  def self.sorted_appointments
    all.sort_by {|appointment| appointment.datetime}
  end
end
