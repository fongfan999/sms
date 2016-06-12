class Klass < ActiveRecord::Base
  belongs_to :grade
  has_many :students
end
