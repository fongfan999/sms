class Mark < ActiveRecord::Base
	has_many :scores
  has_and_belongs_to_many :conducts
  validate :minimum_point
  validate :maximum_point

  after_update :determine_ability

  def get_mimimum_point
    Rule.find(1).min_point
  end

  def get_maximum_point
    Rule.find(1).max_point
  end

  private

  def minimum_point
    errors.add(:point, "is too low") if point < get_mimimum_point
  end

  def maximum_point
    errors.add(:point, "is too high") if point > get_maximum_point
  end

  def determine_ability
    Score.all.each do |score|
      score.determine_ability
    end
  end
end
