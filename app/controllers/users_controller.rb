class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		if @user.nil?
			render :nothing => true
		end
	end
end