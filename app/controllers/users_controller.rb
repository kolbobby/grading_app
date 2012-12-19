class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		if @user.nil?
			render :action => 'static_pages#index'
		end
	end
end