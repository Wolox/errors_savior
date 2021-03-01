class AddIndexToUsersNumber < ActiveRecord::Migration[5.2]
  def change
    add_index :dummies, :number, unique: true
  end
end
