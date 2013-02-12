class ActivitiesController < ApplicationController
	def add
		activities = Activity.find(:all, :conditions => { :coach => params[:coach] })
		render :json => activities
	end
end