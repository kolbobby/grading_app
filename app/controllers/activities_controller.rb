class ActivitiesController < ApplicationController
	def add
		respond_to do |format|
			format.html { render :layout => false }
		end
		return params[:coach]
	end
end