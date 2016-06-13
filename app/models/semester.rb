class Semester < ActiveRecord::Base
	has_many :scores
	has_many :students, through: :scores

	def to_s
		name
	end
end
