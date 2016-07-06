class Student < ActiveRecord::Base
	attr_accessor :current_klass

	belongs_to :klass, counter_cache: true
	has_many :scores, dependent: :destroy
	has_many :semesters, through: :scores
	belongs_to :mark
	belongs_to :conduct
	belongs_to :ability, class_name: "Mark"
	has_one :account, class_name: "User", dependent: :destroy

	validates :first_name, presence: true, length: { maximum: 7 }
	validates :last_name, presence: true, length: { maximum: 28 }
	validates :date_of_birth, presence: true
	validates :klass_id, presence: true
	validate :max_students_in_the_class
	validate :min_student_age
	validate :max_student_age

	after_create :assign_student_code
	after_update :determine_ability

	scope :gender_filtered_chart, ->(params) do
		mappings = { false => "Nữ", true => "Nam" }
		Student.ransack(params[:q]).result(distinct: true).group(:gender).count.map { |k, v| [mappings[k], v] }
	end

	scope :age_filtered_chart, ->(params) do
		results = Student.ransack(params[:q]).result(distinct: true).group_by { |s| s.date_of_birth.year }
		results.sort_by { |k, v| k }.map { |k, v| [k, v.count] }
	end

	scope :ability_filtered_chart, ->(params) do
		mappings = { 1 => "Giỏi", 2 => "Khá", 3 => "Trung Bình", 4 => "Yếu",
			5 => "Kém" }
		results = Student.ransack(params[:q]).result(distinct: true).group(:ability_id).count
		results.map { |k, v| [mappings[k], v] }
	end

	after_create :initialize_scores

	def id_code
		length = id.to_s.length
		tail = "0"*4
		tail.slice!("0"*length)
		"1452#{tail}#{id}"
	end

	def assign_student_code
		update_columns(student_code: id_code)
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

	def to_conduct
		conduct.nil? ? "Chưa cập nhật" : conduct.name
	end

	def to_ability
		if ability.nil?
			final_gpa
		else
			"#{final_gpa} (#{ability.name})"
		end
	end

	def determine_ability
		return if self.final_gpa.nil?
		Mark.all.each do |record|
			if self.final_gpa >= record.point
				self.update_columns(mark_id: record.id)
				if self.conduct_id.nil?
					self.update_columns(ability_id: record.id)
				else
					if record.id >= self.conduct_id
						self.update_columns(ability_id: record.id)
					else
						self.update_columns(ability_id: conduct_id)						
					end
				end  
				break
			end
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
