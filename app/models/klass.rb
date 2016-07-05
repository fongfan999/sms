class Klass < ActiveRecord::Base
  belongs_to :grade
  has_many :students, dependent: :destroy
  belongs_to :teacher

  def scores(semester)
  	ids = students.map(&:id)
  	Score.where("student_id IN (?) AND semester_id = ? ", ids, semester.id)
  end

  def teacher_name
    teacher.nil? ? "Chưa có" : teacher.name
  end
end
