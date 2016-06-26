class Detail < ActiveRecord::Base
	belongs_to :course
	belongs_to :score

	validates :audition, :semi_final, :final, presence: true, 
	numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
	# delegate :score, to: :student

	after_update :cal_gpa

	scope :contain, ->(scores, course, single = false) do
		result = if single
			where(score_id: scores.id, course_id: course.id).first
		else
			result = where("score_id IN (?) AND course_id = ?", scores.map(&:id),
				course.id)
			result.sort_by{|detail| detail.score.student.first_name }
		end
	end

	def cal_gpa
		result = ((audition + semi_final * 2 + final * 3)/6).round(1)
		self.update_columns(gpa: result)

		gpa = score.details.inject(0) { |result, detail| result += detail.gpa }
		gpa = (gpa/Course.count).round(1)
		score.update(gpa: gpa)
	end
end
