class RuleController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    @rule = Rule.first
  end
end
