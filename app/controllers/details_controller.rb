class DetailsController < ApplicationController
	before_action :set_klass, only: [:index, :edit, :update, :reset_score]
	before_action :set_semester, only: [:index, :edit, :update, :reset_score]
	before_action :set_course, only: [:index, :edit, :update, :reset_score]
	before_action :set_details, only: [:index, :edit, :update]
	before_action :set_detail, only: [:edit, :update, :reset_score]

	def index
	end

	def edit
	end

	def update
		if @detail.update(detail_params)
			flash[:notice] = "Score was successfully updated"
      redirect_to klass_semester_course_details_path(@klass, @semester,
      	@course)
    else
      flash.now[:alert] = "Score was not successfully updated"
      render :edit
		end
	end

	def reset_score
		@detail.update(audition: 0, semi_final: 0, final: 0)
		flash[:notice] = "Score was successfully reseted"
		redirect_to klass_semester_course_details_path(@klass, @semester,
      	@course)
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

  def set_details
  	@scores = @klass.scores(@semester)
		@details = Detail.contain(@scores, @course)
  end

  def set_detail
  	@detail = Detail.find(params[:id])
  end

  def detail_params
  	params.require(:detail).permit(:audition, :semi_final, :final)
  end
end
