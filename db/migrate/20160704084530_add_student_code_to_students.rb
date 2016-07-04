class AddStudentCodeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :student_code, :string
  end
end
