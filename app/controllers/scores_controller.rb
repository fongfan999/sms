class ScoresController < ApplicationController
	before_action :set_klass

	def index
		@scores = Score.all
	end

	private
	
  def set_klass
    @klass = Klass.find(params[:klass_id])
  end
end
