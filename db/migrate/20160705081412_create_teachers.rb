class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.boolean :gender, default: true

      t.timestamps null: false
    end
  end
end
