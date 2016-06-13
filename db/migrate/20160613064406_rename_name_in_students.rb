class RenameNameInStudents < ActiveRecord::Migration
  def change
  	rename_column :students, :name, :first_name
  	add_column :students, :last_name, :string
  end
end
