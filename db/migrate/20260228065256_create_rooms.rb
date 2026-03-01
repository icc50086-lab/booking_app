class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :address
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
