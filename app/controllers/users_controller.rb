class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def view_students
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
end