class AddTeacherToKlasses < ActiveRecord::Migration
  def change
    add_reference :klasses, :teacher, index: true, foreign_key: true
  end
end
