class Klass < ActiveRecord::Base
  belongs_to :grade
  has_many :students, dependent: :destroy

  def scores(semester)
  	ids = students.map(&:id)
  	Score.where("student_id IN (?) AND semester_id = ? ", ids, semester.id)
  end
end
