class Student < ActiveRecord::Base
	belongs_to :klass, counter_cache: true
	has_many :scores, dependent: :destroy
	has_many :semesters, through: :scores

	after_create :initialize_scores

	def id_code
		length = id.to_s.length
		tail = "0"*4
		tail.slice!("0"*length)
		"1452#{tail}#{id}"
	end

	def name
		last_name + " " + first_name
	end

	def to_gender
		gender ? "Nam" :  "Nữ"
	end

	def semester_gpa(semester)
		score = self.scores.find_by(semester_id: semester.id)

		"#{score.gpa} (#{score.ability})"
	end

	def ability(semester_id)
		semester_gpa(semester_id) < 5 ? "(Không Đạt)" : "(Đạt)"
	end

	private

	def initialize_scores
		semesters << Semester.all

		scores.all.each do |score|
			score.courses << Course.all
		end
	end
end
