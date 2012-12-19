class User < ActiveRecord::Base
  attr_accessible :name

  before_save { self.name.downcase! }
  validates :name, :presence => :true, :length => { :maximum => 50 }
end
