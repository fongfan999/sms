class AddStudentToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :student, index: true, foreign_key: true
  end
end
