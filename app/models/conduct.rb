class Conduct < ActiveRecord::Base
	has_many :scores
	
	def to_name
		name ||= "Chưa cập nhật."
	end
end
