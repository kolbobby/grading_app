class User < ActiveRecord::Base
  attr_accessible :name, :uname, :password, :password_confirmation
  has_secure_password

  before_save { self.uname.downcase! }
  before_save :create_remember_token
  before_save :set_defaults
  validates :name, :presence => true, :length => { :maximum => 150 }
  validates :uname, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :length => { :minimum => 4 }
  validates :password_confirmation, :presence => true

  private
  	def create_remember_token
  		self.remember_token = SecureRandom.hex
  	end
    def set_defaults
      self.u_type = 1 unless self.u_type
    end
end