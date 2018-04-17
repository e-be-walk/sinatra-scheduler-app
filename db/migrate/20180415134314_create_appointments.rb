class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :content
      t.string :datetime 
      t.integer :user_id
    end
  end
end
