class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.string :booking_code, null:false
      t.datetime :start_date, null:false
      t.datetime :end_date, null:false
      t.decimal :count_price, null: false
      t.integer :room_id, null:false
      t.integer :user_id, null:false
      t.timestamps
    end
  end
end
