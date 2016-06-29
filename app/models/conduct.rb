class Conduct < ActiveRecord::Base
	has_many :scores
  has_and_belongs_to_many :marks
	
	def to_name
		name ||= "Chưa cập nhật."
	end
end
