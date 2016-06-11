class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :name
      t.integer :max_classes, default: 40

      t.timestamps null: false
    end
  end
end
