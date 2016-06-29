class Admin::RulesController < Admin::ApplicationController
  def index
    @rule = Rule.first || Rule.create
  end

  def edit
    @rule = Rule.find(params[:id])
    @attr = params[:attr]
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

  def edit_ability
    @marks = Mark.all
    @conducts = Conduct.all
  end

  def update_ability
    new_params = params.require(:update_ability).require(:marks)
    new_params.each do |param|
      mark = Mark.find(param[0])
      mark.conducts.delete_all
      mark.conducts << Conduct.find(param[1]["conduct"])
    end

    flash[:notice] = "Rule has been successfully updated."
    redirect_to admin_rules_path
  end
end
