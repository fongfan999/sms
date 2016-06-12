class Detail < ActiveRecord::Base
  belongs_to :course
  belongs_to :score
end
