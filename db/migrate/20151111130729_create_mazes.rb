class CreateMazes < ActiveRecord::Migration
  def change
    create_table :mazes do |t|
      t.timestamps null: false
      t.string :generator
      t.integer :width
      t.integer :height
    end
  end
end
