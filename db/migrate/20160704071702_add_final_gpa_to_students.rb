class AddFinalGpaToStudents < ActiveRecord::Migration
  def change
    add_column :students, :final_gpa, :float
  end
end
