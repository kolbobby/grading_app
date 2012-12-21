class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_uname(params[:session][:uname])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
		else
			flash.now[:error] = 'Invalid username/password combination'
			render 'new'
		end
	end

	def destroy
	end
end