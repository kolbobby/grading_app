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
		users = params[:users]

		(users.size).times do |u|
			user = users[u].split(/,/)
			@new_user = User.new(:name => user[0], :uname => user[0], :period => user[1], :grade_level => user[2], :sign_in_teacher => user[3], :password => "foobar", :password_confirmation => "foobar")
			if @new_user.save
				flash[:success] = "User #{@user[:name]} was added to the database"
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