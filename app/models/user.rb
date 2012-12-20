class User < ActiveRecord::Base
  attr_accessible :name

  before_save { self.uname.downcase! }
  validates :name, :presence => :true, :length => { :maximum => 150 }
  validates :uname, :uniqueness => { :case_sensitive => false }
end