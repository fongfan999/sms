class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer :max_quantity, default: 40
      t.integer :max_age, default: 20
      t.integer :min_age, default: 15
      t.float :max_point, default: 10.0
      t.float :min_point, default: 0.0

      t.timestamps null: false
    end
  end
end
