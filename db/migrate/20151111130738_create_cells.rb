class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.timestamps null: false
      t.boolean :carved_north, default: false
      t.boolean :carved_south, default: false
      t.boolean :carved_east, default: false
      t.boolean :carved_west, default: false
    end
  end
end
