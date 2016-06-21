class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.string :name
      t.float :point
      t.string :color

      t.timestamps null: false
    end
  end
end
