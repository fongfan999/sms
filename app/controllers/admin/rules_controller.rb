class Admin::RulesController < Admin::ApplicationController
  def index
    @rule = Rule.first || Rule.create
  end

  def edit
    @rule = Rule.find(params[:id])
  end

  def update
    @rule = Rule.find(params[:id])
    rule_params = params.require(:rule).permit(:max_quantity, :min_age,
      :max_age, :min_point, :max_point)

    if @rule.update(rule_params)
      flash[:notice] = "Rule has been successfully updated."
      redirect_to admin_rules_path
    else
      flash.now[:alert] = "Rule has not been successfully updated."
      render :edit
    end
  end
end
