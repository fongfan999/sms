class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.date :date_of_birth
      t.boolean :gender, default: true
      t.text :address
      t.string :email
      t.references :klass, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
