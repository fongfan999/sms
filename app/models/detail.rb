class Detail < ActiveRecord::Base
	belongs_to :course
	belongs_to :score

	validates :audition, :semi_final, :final, presence: true
	validate :minimum_point
	validate :maximum_point
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

		new_gpa = score.student.scores.inject(0) { |sum, s| sum += s.gpa } / 2
		score.student.update(final_gpa: new_gpa.round(1))
	end

	def get_mimimum_point
		Rule.find(1).min_point
	end

	def get_maximum_point
		Rule.find(1).max_point
	end

	private

	def minimum_point
		errors.add(:audition, "is too low") if audition < get_mimimum_point
		errors.add(:semi_final, "is too low") if semi_final < get_mimimum_point
		errors.add(:final, "is too low") if final < get_mimimum_point
	end

	def maximum_point
		errors.add(:audition, "is too high") if audition > get_maximum_point
		errors.add(:semi_final, "is too high") if semi_final > get_maximum_point
		errors.add(:final, "is too high") if final > get_maximum_point
	end
end
