class User < ActiveRecord::Base
  attr_accessible :name, :uname, :password, :password_confirmation
  has_secure_password

  before_save { self.uname.downcase! }
  validates :name, :presence => true, :length => { :maximum => 150 }
  validates :uname, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :length => { :minimum => 4 }
  validates :password_confirmation, :presence => true
end