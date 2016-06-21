class Admin::StudentsController < Admin::ApplicationController
  def index
    @students = Student.all
  end

  # DELETE /students/1
  def destroy
  	@student = Student.find(params[:id])
    @student.destroy
    
    flash[:notice] = "Student was successfully destroyed."
    redirect_to klass_students_path
  end
end
