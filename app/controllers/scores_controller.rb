class ScoresController < ApplicationController
  before_action :set_klass
  before_action :set_student
  before_action :set_score

  def edit
    @scores = @student.scores
    @score_1 = @scores.first
    @score_2 = @scores.last
    @courses = Course.all
  end

  def update
    if @score.update(params.require(:score).permit(:conduct_id))
      flash[:notice] = "Conduct has been successfully updated."
      redirect_to [@klass, @student]
    else
      flash.now[:alert] = "Conduct has not been successfully updated."
      render :edit
    end
  end


  private

  def set_klass
    @klass = Klass.find(params[:klass_id])
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_score
    @score = Score.find(params[:id])
  end
end
