class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :room_code, null: false, limit: 40
      t.text :description, null:false, limit: 200
      t.integer :hotel_id, null:false
      t.decimal :price, null: false, limit: 255
      t.timestamps
    end
  end
end
