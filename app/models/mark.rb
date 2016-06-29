class Mark < ActiveRecord::Base
	has_many :scores
  has_and_belongs_to_many :conducts
end
