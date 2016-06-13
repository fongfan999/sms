class ScoresController < ApplicationController
	before_action :set_klass
	before_action :set_semester
	before_action :set_course

	def index
		@scores = @klass.scores(@semester)
		@details = Detail.contain(@scores, @course)
	end

	private

  def set_klass
    @klass = Klass.find(params[:klass_id])
  end

  def set_semester
    @semester = Semester.find(params[:semester_id])
  end

  def set_course
  	@course = Course.find(params[:course_id])
  end
end
