class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @q = Notification.ransack(params[:q])
    @notifications = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end
end
