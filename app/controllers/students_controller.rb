class StudentsController < ApplicationController
  before_action :set_klass
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students/1
  def show
  end

  # GET /students/new
  def new
    @student = @klass.students.build
  end

  # GET /students/1/edit
  def edit
    respond_to do |format|
      format.html
      format.json { render json: @student.gender }
    end
  end

  # POST /students

  def create
    @student = @klass.students.build(student_params)

    if @student.save
      flash[:notice] = "Student was successfully created."
      redirect_to @klass
    else
      flash.now[:alert] = "Student was not successfully created."
      render :new
    end
  end

  # PATCH/PUT /students/1

  def update
    if @student.update(student_params)
      flash[:notice] = "Student was successfully updated."
      redirect_to @klass
    else
      flash.now[:alert] = "Student was successfully updated."
      render :edit
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
    
    flash[:notice] = "Student was successfully destroyed."
    redirect_to klass_students_path
  end

  private
    
    def set_klass
      @klass = Klass.find(params[:klass_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :date_of_birth, :gender, :address,
        :email)
    end
end
