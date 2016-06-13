class Admin::StudentsController < Admin::ApplicationController
  def index
    @students = Student.all
  end
end
