class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def view_home
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
	def view_students
		@users = User.all
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
	def manage_students
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
	def add_bulk_users_to_db
		redirect_to root_path
		respond_to do |format|
			format.js { render :layout => false }
		end
	end

	private
		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_path, :notice => "Please sign in."
			end
		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
end