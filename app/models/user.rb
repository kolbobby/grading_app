class User < ActiveRecord::Base
  attr_accessible :name

  before_save { |user| user.name = name.downcase }
  validates :name, :presence => :true, :length => { :maximum => 50 }, :uniqueness => { :case_sensitive => false }
end
