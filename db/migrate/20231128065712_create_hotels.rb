class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.string :name, null:false,limit: 100
      t.string :address,null:false,limit: 150
      t.text :description,null:false,limit: 200
      t.timestamps
    end
  end
end
