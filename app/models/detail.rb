class Detail < ActiveRecord::Base
  belongs_to :course
  belongs_to :score

  # delegate :score, to: :student

  scope :contain, ->(scores, course) do
  	where("score_id IN (?) AND course_id = ?", scores.map(&:id), course.id)
  end
end
