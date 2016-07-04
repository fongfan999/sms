class AddAbilityToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :ability, index: true
    add_foreign_key :students, :marks, column: :ability_id
  end
end
