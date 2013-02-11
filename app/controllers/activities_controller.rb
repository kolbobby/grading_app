class ActivitiesController < ApplicationController
	def add
		respond_to do |format|
			format.js { render :layout => false }
		end
		return params[:coach]
	end
end