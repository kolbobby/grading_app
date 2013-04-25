class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def view_home
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
	def setup_teachers
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
	def view_students
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
	def view_roster
		require 'nokogiri'
		doc = Nokogiri::XML(open(Rails.root.join('app', 'student_activities.xml')))
		@students = doc.xpath("//student")
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
	def manage_students
		require 'nokogiri'
		doc = Nokogiri::XML(open(Rails.root.join('app', 'student_activities.xml')))
		@students_xml = doc.xpath("//student")
		respond_to do |format|
			format.js { render :layout => false }
		end
	end
	def reload_students
		require 'nokogiri'
		doc = Nokogiri::XML(open(Rails.root.join('app', 'student_activities.xml')))
		@students_xml = doc.xpath("//student")
		respond_to do |format|
			format.html { render :partial => '/students/student', :locals => { :over => false, :view => false, :students_xml => @students_xml, :mp => params[:marking], :act => params[:activity] } }
		end
	end
	def manage_activities
		respond_to do |format|
			format.js { render :layout => false }
		end
	end

	def add_user
		@new_user = User.new(:name => params[:u_name], :uname => params[:u_uname], :password => params[:u_password], :password_confirmation => params[:u_password])
		@new_user.teacher = true

		if @new_user.save
			flash[:success] = "Added"
		else
			flash[:failure] = "Failed"
		end
	end

	def update_schedules
		@teachers = User.all
		str = ""
		@teachers.each do |t|
			schedule = Array.new
			4.times do |x|
				#str = "#{str}#{t[:name]}_marking_period_#{(x+1)}"
				schedule.push(params["#{str}#{t[:name]}_marking_period_#{(x+1)}"])
			end
			#str = "#{str}\n"
			schedule.each do |s|
				str = "#{str}#{s}\n"
			end
		end
		flash[:success] = "#{str}"
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