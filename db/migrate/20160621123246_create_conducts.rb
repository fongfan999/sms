class CreateConducts < ActiveRecord::Migration
  def change
    create_table :conducts do |t|
      t.string :name
      t.integer :priority
      t.string :color

      t.timestamps null: false
    end
  end
end
