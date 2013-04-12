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
		builder = Nokogiri::XML(open(Rails.root.join('app', 'student_activities.xml')))

		root = builder.xpath("//root").first
		students.each do |s|
			node = Nokogiri::XML::Node.new "student", builder
			name = Nokogiri::XML::Node.new "name", builder
			activity = Nokogiri::XML::Node.new "activity", builder

			name.content = s
			activity.content = params[:activity]

			node << name
			node << activity
			root << node

			builder.to_xml
		end

		render :text => "ADDED TO ACTIVITY!"
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