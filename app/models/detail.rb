class Detail < ActiveRecord::Base
  belongs_to :course
  belongs_to :score

  validates :audition, :semi_final, :final, presence: true,
  	numericality: { minimum: 0, maximum: 10 }
  # delegate :score, to: :student

  after_update :cal_gpa

  scope :contain, ->(scores, course) do
  	where("score_id IN (?) AND course_id = ?", scores.map(&:id), course.id)
  end

  private

  def cal_gpa
  	result = ((audition + semi_final * 2 + final * 3)/6).round(1)
  	self.update_columns(gpa: result)
  end
end
