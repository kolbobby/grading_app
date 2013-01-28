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
	def add_teacher
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
	def manage_students
		respond_to do |format|
			format.js { render :layout => false }
		end
	end

	def add_user
		if params[:teacher]
			@new_user = User.new(:name => params[:u_name], :uname => params[:u_uname], :teacher => true, :password => params[:u_password], :password_confirmation => params[:u_password])
		else
			@new_user = Student.new(:name => params[:u_name], :period => params[:u_period], :grade_level => params[:grade_level], :sign_in_teacher => params[:sign_in_teacher])
		end

		if @new_user.save
			flash[:success] = "Added"
		else
			flash[:failure] = "Failed"
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