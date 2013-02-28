class ActivitiesController < ApplicationController
	def change_coach
		activities = Activity.find(:all, :conditions => { :coach => params[:coach] })
		render :json => activities
	end

	def get_activity
		activity = Activity.find(:first, :conditions => { :marking_period => params[:mp], :acitivity_number => params[:act] })
		render :text => activity.name
	end

	def add_activities
		coach = params[:coach]
		activities = params[:acts]
		str = ""

		count = 1
		mp = 1
		activities.each do |a|
			if count > 3
				count = 1
				mp = mp + 1
			end
			str = "#{str}Name: #{a}, Activity Number: #{count}, Marking Period: #{mp}, Coach: #{coach}\n"
			count = count + 1
		end

		render :text => str
	end

	def confirm_add_activities
		coach = params[:coach]
		activities = params[:acts]
		str = ""

		count = 1
		mp = 1
		activities.each do |a|
			if count > 3
				count = 1
				mp = mp + 1
			end
			activity = Activity.new(:activity_number => count, :coach => coach, :marking_period => mp, :name => a)
			if activity.save
				str = "#{str}#{count}: saved\n"
			else
				str = "#{str}#{count}: not saved\n" 
			end
			count = count + 1
		end

		render :text => str
	end
end