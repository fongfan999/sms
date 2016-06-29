class CreateJoinTableMarksAndConducts < ActiveRecord::Migration
  def change
    create_join_table :marks, :conducts do |t|
      t.index [:mark_id, :conduct_id]
      t.index [:conduct_id, :mark_id]
    end
  end
end
