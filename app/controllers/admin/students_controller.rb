class Admin::StudentsController < Admin::ApplicationController
  def index
    @q = Student.ransack(params[:q])
    @students = @q.result(distinct: true)

    @gender_chart = Student.gender_filtered_chart(params)
    @age_chart = Student.age_filtered_chart(params)
    @ability_chart = Student.ability_filtered_chart(params)
  end

  def search
    index
    render :index
  end

  # DELETE /students/1
  def destroy
  	@student = Student.find(params[:id])
    @klass = @student.klass
    @student.destroy
    
    flash[:notice] = "Student was successfully destroyed."
    redirect_to @klass
  end
end
