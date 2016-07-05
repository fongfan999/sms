class Admin::KlassesController < Admin::ApplicationController
  before_action :set_klass, only: [:edit, :update, :destroy]

  # GET /admin/klasses
  def index
    @klasses = Klass.all
  end

  # GET /admin/klasses/new
  def new
    @klass = Klass.new
  end

  # GET /admin/klasses/1/edit
  def edit
  end

  # POST /admin/klasses
  def create
    @klass = Klass.new(klass_params)

    if @klass.save
      flash[:notice] = "Class was successfully created."
      redirect_to @klass
    else
      flash.now[:alert] = "Class was not successfully created."
      render :new
    end
  end

  # PATCH/PUT /admin/klasses/1
  def update
    if @klass.update(klass_params)
      # @klass.attributes = params.require(:klass).permit(:teacher)
      flash[:notice] = "Class was successfully updated"
      redirect_to @klass
    else
      flash.now[:alert] = "Class was not successfully updated"
      render :edit
    end
  end

  # DELETE /admin/klasses/1
  def destroy
    @klass.destroy
    flash[:notice] = "Class was successfully destroyed."
    redirect_to admin_klasses_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_klass
      @klass = Klass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def klass_params
      params.require(:klass).permit(:name, :grade_id, :teacher_id)
    end
end
