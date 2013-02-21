class ActivitiesController < ApplicationController
	def change_coach
		activities = Activity.find(:all, :conditions => { :coach => params[:coach] })
		render :json => activities
	end
end