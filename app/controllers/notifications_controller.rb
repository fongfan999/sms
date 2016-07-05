class NotificationsController < ApplicationController
  def show
    @student = Student.first
  end
end
