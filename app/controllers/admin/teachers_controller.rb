class Admin::TeachersController < Admin::ApplicationController
  before_action :set_teacher, only: [:edit, :update, :destroy]

  # GET /teachers
  # GET /teachers.json
  def index
    @q = Teacher.ransack(params[:q])
    @teachers = @q.result(distinct: true)

    @gender_chart = Teacher.gender_filtered_chart(params)
    @age_chart = Teacher.age_filtered_chart(params)
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      @teacher.account = User.create(
        email: @teacher.generate_id + "@uit.edu.vn",
        password: @teacher.generate_id)
      @teacher.save
      flash[:notice] = "Teacher was successfully created."
      redirect_to admin_teachers_path
    else
      flash.now[:alert] = "Teacher was not successfully created."
      render :new
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    if @teacher.update(teacher_params)
      @teacher.account.update(
        email: @teacher.generate_id + "@uit.edu.vn",
        password: @teacher.generate_id)
      flash[:notice] = "Teacher was successfully updated."
      redirect_to admin_teachers_path
    else
      flash.now[:alert] = "Teacher was successfully updated."
      render :edit
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy
    
    flash[:notice] = "Teacher was successfully destroyed."
    redirect_to admin_teachers_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:first_name, :last_name, :date_of_birth, :gender)
    end
end
