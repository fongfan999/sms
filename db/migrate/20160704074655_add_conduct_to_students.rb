class AddConductToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :conduct, index: true, foreign_key: true
  end
end
