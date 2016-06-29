# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Initialize Grade
unless Grade.exists?(name: "Khối 10")
	Grade.create(name: "Khối 10")
end

unless Grade.exists?(name: "Khối 11")
	Grade.create(name: "Khối 11")
end

unless Grade.exists?(name: "Khối 12")
	Grade.create(name: "Khối 12")
end

# Initialize Course
unless Course.exists?(name: "Toán học")
	Course.create(name: "Toán học", color: "#1abc9c")
end

unless Course.exists?(name: "Vật Lý")
	Course.create(name: "Vật Lý", color: "#2ecc71")
end

unless Course.exists?(name: "Hóa học")
	Course.create(name: "Hóa học", color: "#3498db")
end

unless Course.exists?(name: "Sinh học")
	Course.create(name: "Sinh học", color: "#9b59b6")
end

unless Course.exists?(name: "Văn học")
	Course.create(name: "Văn học", color: "#34495e")
end

unless Course.exists?(name: "Lịch Sử")
	Course.create(name: "Lịch Sử", color: "#f1c40f")
end

unless Course.exists?(name: "Địa Lý")
	Course.create(name: "Địa Lý", color: "#e67e22")
end

unless Course.exists?(name: "Tiếng Anh")
	Course.create(name: "Tiếng Anh", color: "#e74c3c")
end

# Initialize Semester
unless Semester.exists?(name: "Học kỳ 1")
	Semester.create(name: "Học kỳ 1")
end

unless Semester.exists?(name: "Học kỳ 2")
	Semester.create(name: "Học kỳ 2")
end

Student.all.each do |student|
	Semester.all.each do |semester|
		student.semesters << semester unless student.semesters.include?(semester)
	end
end

Score.all.each do |score|
	Course.all.each do |course|
		score.courses << course unless score.courses.include?(course)
	end
end

# Initialize Conduct
unless Conduct.exists?(name: "Tốt")
	Conduct.create(name: "Tốt", priority: 1, color: "#006064")
end

unless Conduct.exists?(name: "Khá")
	Conduct.create(name: "Khá", priority: 2, color: "#00838F")
end

unless Conduct.exists?(name: "Trung Bình")
	Conduct.create(name: "Trung Bình", priority: 3, color: "#0097A7")
end

unless Conduct.exists?(name: "Yếu")
	Conduct.create(name: "Yếu", priority: 4, color: "#00ACC1")
end

unless Conduct.exists?(name: "Kém")
	Conduct.create(name: "Kém", priority: 5, color: "#00BCD4")
end

# Initialize Mark
unless Mark.exists?(name: "Giỏi")
	mark = Mark.create(name: "Giỏi", point: 8, color: "#004D40")
	mark.conducts << Conduct.find(1)
end

unless Mark.exists?(name: "Khá")
	mark = Mark.create(name: "Khá", point: 6.5, color: "#00695C")
	mark.conducts << Conduct.find(2)
end

unless Mark.exists?(name: "Trung Bình")
	mark = Mark.create(name: "Trung Bình", point: 5, color: "#00796B")
	mark.conducts << Conduct.find(3)
end

unless Mark.exists?(name: "Yếu")
	mark = Mark.create(name: "Yếu", point: 3.5, color: "#00897B")
	mark.conducts << Conduct.find(4)
end

unless Mark.exists?(name: "Kém")
	mark = Mark.create(name: "Kém", point: 0, color: "#009688")
	mark.conducts << Conduct.find(5)
end