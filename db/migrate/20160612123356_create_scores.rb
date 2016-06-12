class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.float :gpa, default: 0
      t.references :student, index: true, foreign_key: true
      t.references :semester, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
