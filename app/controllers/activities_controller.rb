class ActivitiesController < ApplicationController
	def change_coach
		activities = Activity.find(:all, :conditions => { :coach => params[:coach] })
		render :json => activities
	end

	def get_activity
		activity = Activity.find(:first, :conditions => { :coach => params[:coach], :marking_period => params[:mp], :activity_number => params[:act] })
		render :text => activity.name
	end

	def add_activities
		coach = params[:coach]
		activities = params[:acts]
		str = ""

		count = 0
		activities.each do |a|
			str = "#{str}Name: #{a[count][1][0]}, Activity Number: #{a[count][1][2]}, Marking Period: #{a[count][1][1]}, Coach: #{coach}\n"
			count = count + 1
		end

		render :text => str
	end

	def confirm_add_activities
		coach = params[:coach]
		activities = params[:acts]
		str = ""

		existing_activities = Activity.find(:all, :conditions => { :coach => coach })
		if existing_activities.count == 12
			count = 0
			existing_activities.each do |e|
				act = Activity.find(:first, :conditions => { :coach => coach, :marking_period => activities[count][1], :activity_number => activities[count][2] })
				act.update_attribute(:name, activities[count][0])
				count = count + 1
			end
		else
			if existing_activities.count > 0
				existing_activities.each do |e|
					Activity.find(:first, :conditions => { :coach => coach, :name => e.name, :marking_period => e.marking_period }).destroy
				end
			end
			count = 0
			activities.each do |a|
				activity = Activity.new(:activity_number => a[2], :coach => coach, :marking_period => a[1], :name => a[0])
				if activity.save
					str = "#{str}#{a[count][1]}, #{a[count][2]}: added\n"
				else
					str = "#{str}#{a[count][1]}, #{a[count][2]}: not added\n" 
				end
				count = count + 1
			end
		end

		render :text => str
	end
end