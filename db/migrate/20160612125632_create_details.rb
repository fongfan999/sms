class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.float :audition, default: 0
      t.float :semi_final, default: 0
      t.float :final, default: 0
      t.references :course, index: true, foreign_key: true
      t.references :score, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
