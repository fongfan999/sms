class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  # before_action :navigating_page!
  def index
    @q = Notification.ransack(params[:q])
    @notifications = @q.result(distinct: true)
  end
end
