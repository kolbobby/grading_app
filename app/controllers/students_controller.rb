class StudentsController < ApplicationController
	def show
		@student = Student.find(params[:id])
	end

	def add_student
		@new_user = Student.new(:name => params[:u_name], :period => params[:u_period], :grade_level => params[:u_grade_level], :sign_in_teacher => params[:u_sign_in_teacher])

		if @new_user.save
			flash[:success] = "Added"
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
			@new_user = Student.new(:name => n_user[n_u][0], :period => n_user[n_u][1], :grade_level => n_user[n_u][2], :sign_in_teacher => n_user[n_u][3])
			
			if @new_user.save
				flash[:success] = "Added #{n_u + 1} students"
			else
				flash[:failure] = "Failed"
			end
		end
	end
end