class Score < ActiveRecord::Base
	belongs_to :student
	belongs_to :semester
	has_many :details, dependent: :destroy
	has_many :courses, through: :details
	belongs_to :mark
	belongs_to :conduct
	belongs_to :ability, class_name: "Mark"

	after_update :determine_ability

	scope :ability_chart, ->(semester_id) do
		mappings = { 1 => "Giỏi", 2 => "Khá", 3 => "Trung Bình", 4 => "Yếu", 
			5 => "Kém" }
		results = Score.where(semester_id: semester_id).group(:ability_id).count

		if results[0].nil? && results.count == 1
			[["Dữ liệu trống", 5]]
		else
			results.map { |k, v| [mappings[k], v] }
		end
	end

	def to_name(str)
		if str == "mark"
			mark_id.nil? ? "Chưa cập nhật" : Mark.find(mark_id).name
		else
			conduct.nil? ? "Chưa cập nhật" : conduct.name
		end
	end

	def determine_ability
		Mark.all.each do |record|
			# position_of_mark = record.id
			# position_of_mark -= 5 if Mark.count == 10

			if self.gpa >= record.point
				self.update_columns(mark_id: record.id)
				if self.conduct_id.nil?
					self.update_columns(ability_id: record.id)
				else
					if record.id >= self.conduct_id
						self.update_columns(ability_id: record.id)
					else
						# position_of_mark = self.conduct_id
						# position_of_mark += 5 if Mark.count == 10
						self.update_columns(ability_id: conduct_id)						
					end
				end  
				break
			end
		end
	end
end
