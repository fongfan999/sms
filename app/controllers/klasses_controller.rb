class KlassesController < ApplicationController
	def show
		@klass = Klass.find(params[:id])
		@students = @klass.students.order(:first_name)
	end
end
