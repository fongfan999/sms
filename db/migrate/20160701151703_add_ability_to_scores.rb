class AddAbilityToScores < ActiveRecord::Migration
  def change
    add_reference :scores, :ability, index: true
    add_foreign_key :scores, :marks, column: :ability_id
  end
end
