class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.string :name
      t.integer :students_count, default: 0
      t.references :grade, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
