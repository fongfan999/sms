class Score < ActiveRecord::Base
  belongs_to :student
  belongs_to :semester
  has_many :details, dependent: :destroy
	has_many :courses, through: :details
	belongs_to :mark
	belongs_to :conduct

	# scope :ordered, -> do
	# 	includes(:student).order("students.first_name")
	# end

	after_update :determine_mark

	private

	def determine_mark
		Mark.order(point: :desc).each do |record|
			if self.gpa >= record.point
				self.update_columns(mark_id: record.id)
				break
			end
		end
	end
end
