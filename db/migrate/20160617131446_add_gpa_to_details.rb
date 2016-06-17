class AddGpaToDetails < ActiveRecord::Migration
  def change
    add_column :details, :gpa, :float, default: 0
  end
end
