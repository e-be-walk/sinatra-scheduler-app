class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :content
      t.string :datetime
      t.integer :user_id
    end
  end
end
