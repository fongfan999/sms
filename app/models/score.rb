class Score < ActiveRecord::Base
  belongs_to :student
  belongs_to :semester
  has_many :details, dependent: :destroy
	has_many :courses, through: :details

	# scope :ordered, -> do
	# 	includes(:student).order("students.first_name")
	# end
end
