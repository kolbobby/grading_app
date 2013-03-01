class Activity < ActiveRecord::Base
  attr_accessible :activity_number, :coach, :marking_period, :name

  def update_act(new_act)
  	update_attribute :name, new_act
  	render :text => "#{self.name}"
  end
end