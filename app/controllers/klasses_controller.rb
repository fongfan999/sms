class KlassesController < ApplicationController
	def show
		@klass = Klass.find(params[:id])
    @q = @klass.students.order(:first_name).ransack(params[:q])
		@students = @q.result(distinct: true)
	end
end
