class Admin::RulesController < Admin::ApplicationController
  def index
    @rule = Rule.first
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
    marks_params = params.require(:update_ability).require(:marks).permit!
    results = Mark.update(marks_params.keys,
      marks_params.values).reject { |m| m.errors.empty? }

    if results.empty?
      flash[:notice] = "Rule has been successfully updated."
      redirect_to admin_rules_path
    else
      flash.now[:alert] = "Rule has not been successfully updated."
      @marks = Mark.all - results + results
      @conducts = Conduct.all
      render :edit_ability
    end

  end
end
