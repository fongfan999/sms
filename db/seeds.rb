# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Grade.exists?(name: "Khối 10")
	Grade.create(name: "Khối 10")
end

unless Grade.exists?(name: "Khối 11")
	Grade.create(name: "Khối 11")
end

unless Grade.exists?(name: "Khối 12")
	Grade.create(name: "Khối 12")
end

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

unless Semester.exists?(name: "Học kỳ 1")
	Semester.create(name: "Học kỳ 1")
end
unless Semester.exists?(name: "Học kỳ 2")
	Semester.create(name: "Học kỳ 2")
end