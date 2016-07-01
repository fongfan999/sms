class Score < ActiveRecord::Base
	belongs_to :student
	belongs_to :semester
	has_many :details, dependent: :destroy
	has_many :courses, through: :details
	belongs_to :mark
	belongs_to :conduct

	after_update :determine_mark

	def to_name(str)
		if str == "mark"
			mark_id.nil? ? "Chưa cập nhật" : Mark.find(mark_id).name
		else
			conduct.nil? ? "Chưa cập nhật" : conduct.name
		end
	end

	def ability
		to_name("mark")
	end

	def determine_mark
		Mark.all.each do |record|
			position_of_mark = record.id
			position_of_mark -= 5 if Mark.count == 10

			if self.gpa >= record.point
				if self.conduct_id.nil?
					self.update_columns(mark_id: record.id)
				else
					if position_of_mark >= self.conduct_id
						self.update_columns(mark_id: record.id)
					else
						position_of_mark = self.conduct_id
						position_of_mark += 5 if Mark.count == 10
						self.update_columns(mark_id: position_of_mark)						
					end
				end  
				break
			end
		end
	end
end
