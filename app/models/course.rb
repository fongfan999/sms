class Course < ActiveRecord::Base
	has_many :details, dependent: :destroy
	has_many :scores, through: :details

	def to_s
		name
	end
end
