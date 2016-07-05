class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  # before_action :navigating_page!
	protect_from_forgery with: :exception

  # Student.all.each do |student|
  #   if student.account.nil?
  #     student.account = User.create(
  #     email: student.id_code + "@uit.edu.vn",
  #     password: student.id_code)
  #     student.save
  #   end
  # end

  def navigating_page!
    if current_user.admin?
      redirect_to admin_root_path
    else
      redirect_to current_user.student
    end
  end
end
