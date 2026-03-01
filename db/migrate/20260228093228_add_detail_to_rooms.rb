class AddDetailToRooms < ActiveRecord::Migration[7.2]
  def change
    add_column :rooms, :detail, :text
  end
end
