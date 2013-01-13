class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def view_students
		@users = User.all
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
end