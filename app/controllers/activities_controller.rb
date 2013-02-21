class ActivitiesController < ApplicationController
	def change_coach
		activities = Activity.find(:all, :conditions => { :coach => params[:coach] })
		render :json => activities
	end

	def get_activity
		activity = Activity.find(:first, :conditions => { :marking_period => params[:mp], :acitivity_number => params[:act] })
		render :text => activity.name
	end
end