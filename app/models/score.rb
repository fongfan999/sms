class Score < ActiveRecord::Base
  belongs_to :student
  belongs_to :semester
  has_many :details
end
