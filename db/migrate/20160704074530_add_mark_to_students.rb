class AddMarkToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :mark, index: true, foreign_key: true
  end
end
