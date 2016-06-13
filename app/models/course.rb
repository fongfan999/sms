class Course < ActiveRecord::Base
	has_many :details, dependent: :destroy
	has_many :scores, through: :details

	after_create :initialize_scores

	def to_s
		name
	end

	private

	def initialize_scores
    scores << Score.all
  end
end
