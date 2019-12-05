class CreateDummyModel < ActiveRecord::Migration[5.2]
  def change
    create_table :dummies do |t|
      t.string :name
      t.integer :number
    end
  end
end
