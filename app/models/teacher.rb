class Teacher < ActiveRecord::Base
  # include Reusable
  has_one :account, class_name: "User", dependent: :destroy
  has_one :klass

  scope :gender_filtered_chart, ->(params) do
    mappings = { false => "Nữ", true => "Nam" }
    Teacher.ransack(params[:q]).result(distinct: true).group(:gender).count.map { |k, v| [mappings[k], v] }
  end

  scope :age_filtered_chart, ->(params) do
    results = Teacher.ransack(params[:q]).result(distinct: true).group_by { |s| s.date_of_birth.year }
    results.sort_by { |k, v| k }.map { |k, v| [k, v.count] }
  end

  def name
    last_name + " " + first_name
  end

  def to_gender
    gender ? "Nam" : "Nữ"
  end

  def generate_id
    to_utf((first_name + last_name.split.map(&:first).join("") +
          date_of_birth.year.to_s).to_s.downcase)
  end

  def klass_name
    klass.nil? ? "Chưa có" : klass.name
  end
end
