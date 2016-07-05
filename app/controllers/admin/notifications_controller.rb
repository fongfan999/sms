class Admin::NotificationsController < Admin::ApplicationController
  def new
    @notification = Notification.new
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      flash[:notice] = "Notification was successfully created."
      redirect_to root_path
    else
      flash.now[:alert] = "Notification was not successfully created."
      render :new
    end
  end

  def update
    if @notification.update(notification_params)
      flash[:notice] = "Notification was successfully updated."
      redirect_to root_path
    else
      flash.now[:alert] = "Notification was not successfully updated."
      render :new
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    flash[:notice] = "Notification was successfully deleted."
      redirect_to root_path
  end

  private

  def notification_params
    params.require(:notification).permit(:title, :description)
  end
end
