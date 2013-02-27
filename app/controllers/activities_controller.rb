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
		activities = params[:acts]
		str = ""

		count = 1
		mp = 1
		activities.each do |a|
			if count == 3
				count = 1
				mp = mp + 1
			end
			#activity = Activity.new(:activity_number => count, :coach => , :marking_period => mp, :name => a)
			str = "#{str}Count: #{count}, Marking Period: #{mp}, Name: #{a}\n"
			count = count + 1
		end

		render :text => str
	end
end