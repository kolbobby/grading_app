class ActivitiesController < ApplicationController
	def change_coach
		activities = Activity.find(:all, :conditions => { :coach => params[:coach] })
		render :json => activities
	end

	def get_activity
		activity = Activity.find(:first, :conditions => { :coach => params[:coach], :marking_period => params[:mp], :activity_number => params[:act] })
		render :text => activity.name
	end

	def add_to_activity
		require 'nokogiri'
		students = params[:students]
		io = File.open(Rails.root.join('app', 'student_activities.xml'))
		builder = Nokogiri::XML(io)
		io.close

		x_count = 0
		xml_students = builder.xpath("//student")
		xml_students.each do |xs|
			cur_act = xs.search("activity")
			if cur_act.to_s == params[:activity].to_s
				x_count = x_count + 1
			end
		end
		s_count = 0
		students.each do |s|
			s_count = s_count + 1
		end

		cur_activity = Activity.find(:first, :conditions => { :name => params[:activity], :marking_period => params[:marking], :activity_number => params[:act_num] })
		render :text => "x_count: #{x_count}, s_count: #{s_count}, cap: #{cur_activity[:capacity].to_i}"
		=begin
		if x_count + s_count < cur_activity[:capacity].to_i
			setup = builder.xpath("//setup").last
			students.each do |s|
				student = Nokogiri::XML::Node.new "student", builder

				student.add_child("<name>#{s}</name>")
				student.add_child("<activity>#{params[:activity]}</activity>")
				student.add_child("<marking_period>#{params[:marking]}</marking_period>")
				student.add_child("<activity_number>#{params[:act_num]}</activity_number>")
				setup.add_next_sibling(student)
			end

			io = File.open(Rails.root.join('app', 'student_activities.xml'), "w")
			io.puts builder.to_xml
			io.close

			render :text => "ADDED TO ACTIVITY!"
		else
			if cur_activity[:capacity].to_i - (x_count + s_count) == 1
				render :text => "There is only 1 spot left in this activity!"
			elsif cur_activity[:capacity].to_i - (x_count + s_count) != 0
				render :text => "There are only #{cur_activity[:capacity].to_i - (x_count + s_count)} spots left in this activity!"
			else
				render :text => "There are no spots left in this activity!"
			end
		end
		=end
	end

	def add_activities
		coach = params[:coach]
		activities = params[:acts]
		str = ""

		activities.each do |a|
			str = "#{str}Name: #{a[1][0]}, Activity Number: #{a[1][2]}, Marking Period: #{a[1][1]}, Coach: #{coach}\n"
		end

		render :text => str
	end

	def confirm_add_activities
		coach = params[:coach]
		activities = params[:acts]
		str = ""

		existing_activities = Activity.find(:all, :conditions => { :coach => coach })
		if existing_activities.count > 0
			existing_activities.each do |e|
				Activity.find(:first, :conditions => { :coach => coach, :name => e.name, :marking_period => e.marking_period }).destroy
			end
		end
		activities.each do |a|
			activity = Activity.new(:activity_number => a[1][2], :coach => coach, :marking_period => a[1][1], :name => a[1][0])
			if activity.save
				str = "#{str}#{a[1][1]}, #{a[1][2]}: added\n"
			else
				str = "#{str}#{a[1][1]}, #{a[1][2]}: not added\n" 
			end
		end

		render :text => str
	end
end