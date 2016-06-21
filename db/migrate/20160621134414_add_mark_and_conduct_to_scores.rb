class AddMarkAndConductToScores < ActiveRecord::Migration
  def change
    add_reference :scores, :mark, index: true, foreign_key: true
    add_reference :scores, :conduct, index: true, foreign_key: true
  end
end
