json.array!(@students) do |student|
  json.extract! student, :id, :name, :date_of_birth, :gender, :address, :email, :klass_id
  json.url student_url(student, format: :json)
end
