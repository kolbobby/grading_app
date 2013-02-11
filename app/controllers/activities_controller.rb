class ActivitiesController < ApplicationController
	def add
		render :text => params[:coach]
	end
end