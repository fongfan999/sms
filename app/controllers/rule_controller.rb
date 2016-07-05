class RuleController < ApplicationController
  def index
    @rule = Rule.first
  end
end
