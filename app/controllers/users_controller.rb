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

	def add_user(teacher)
		@new_user = User.new(:name => params[:u_name], :uname => params[:u_uname], :teacher => teacher, :password => params[:u_password], :password_confirmation => params[:u_password])

		if @new_user.save
			flash[:success] = "Added #{@new_user.name}"
		else
			flash[:failure] = "Failed"
		end
	end
	def add_bulk_users_to_db
		users = params[:users]

		n_user = []
		(users.size).times do |u|
			user = users[u].split(/,/)
			n_user[u] = user
		end

		(n_user.size).times do |n_u|
			@new_user = User.new(:name => n_user[n_u][0], :uname => n_user[n_u][0], :password => "foobar", :password_confirmation => "foobar")
			@new_user.period = n_user[n_u][1]
			@new_user.grade_level = n_user[n_u][2]
			@new_user.sign_in_teacher = n_user[n_u][3]
			
			if @new_user.save
				flash[:success] = "Added #{n_u + 1} students"
			else
				flash[:failure] = "Failed"
			end
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