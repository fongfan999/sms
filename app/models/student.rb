class Student < ActiveRecord::Base
	attr_accessor :current_klass

	belongs_to :klass, counter_cache: true
	has_many :scores, dependent: :destroy
	has_many :semesters, through: :scores

	validates :first_name, presence: true, length: { minimum: 1, maximum: 7 }
	validates :last_name, presence: true, length: { minimum: 3, maximum: 28 }
	validates :date_of_birth, presence: true
	validates :gender, presence: true
	validates :klass_id, presence: true
	validate :max_students_in_the_class
	validate :min_student_age
	validate :max_student_age

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
		gender ? "Nam" : "Nữ"
	end

	def semester_gpa(semester)
		score = self.scores.find_by(semester_id: semester.id)

		if score.ability.nil?
			score.gpa
		else
			"#{score.gpa} (#{score.ability.name})"
		end
	end

	def get_min_age
		Rule.find(1).min_age
	end

	def get_max_age
		Rule.find(1).max_age
	end

	def is_class_max?
		max_students = Rule.find(1).max_quantity

		if klass_id_changed?
			klass.students.count == max_students
		end
	end

	private

	def initialize_scores
		semesters << Semester.all

		scores.all.each do |score|
			score.courses << Course.all
		end
	end

	def min_student_age
		if date_of_birth.year < (Date.today.year - get_max_age)
			self.errors.add(:date_of_birth, "is too young")
		end
	end

	def max_student_age
		if date_of_birth.year > (Date.today.year - get_min_age)
			self.errors.add(:date_of_birth, "is too old")
		end
	end

	def max_students_in_the_class
		self.errors.add(:klass, "is limited") if self.is_class_max?
	end
end
