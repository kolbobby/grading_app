class User < ActiveRecord::Base
  attr_accessible :name, :uname, :password_confirmation, :schedule
  has_secure_password

  before_save { self.uname.downcase! }
  before_save :create_remember_token
  validates :name, :presence => true, :length => { :maximum => 150 }
  validates :uname, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :password_confirmation, :presence => true

  private
  	def create_remember_token
  		self.remember_token = SecureRandom.hex
  	end
end