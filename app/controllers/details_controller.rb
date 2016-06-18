class DetailsController < ApplicationController
	before_action :set_klass, only: [:index, :edit, :update, :reset, :edit_all,
    :update_all, :reset_all]
	before_action :set_semester, only: [:index, :edit, :update, :reset, :edit_all,
    :update_all, :reset_all]
	before_action :set_course, only: [:index, :edit, :update, :reset, :edit_all,
    :update_all, :reset_all]
	before_action :set_details, only: [:index, :edit, :update, :edit_all,
    :update_all, :reset_all]

	before_action :set_detail, only: [:edit, :update, :reset]

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

	def reset
		@detail.update(audition: 0, semi_final: 0, final: 0)
		flash[:notice] = "Score was successfully reseted"
		redirect_to klass_semester_course_details_path(@klass, @semester,
      	@course)
	end


  def edit_all
  end

  def update_all
    detail_params = params.require(:update_all).require(:detail)
    @details = Detail.update(detail_params.keys,
      detail_params.values).reject { |d| d.errors.empty? }

    if @details.empty?
      flash[:notice] = "Scores was successfully updated"
      redirect_to klass_semester_course_details_path(@klass, @semester,
        @course)
    else
      flash.now[:alert] = "Scores was not successfully updated"
      render :edit_all
    end
  end

  def reset_all
    @details.update_all(audition: 0, semi_final: 0, final: 0)
    @details.each do |detail|
      detail.cal_gpa
    end
    flash[:notice] = "Scores was successfully reseted"
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
