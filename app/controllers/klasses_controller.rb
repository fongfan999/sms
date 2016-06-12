class KlassesController < ApplicationController
	def show
		@klass = Klass.find(params[:id])
		@students = @klass.students
	end
end
