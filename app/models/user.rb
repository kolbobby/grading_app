class User < ActiveRecord::Base
  attr_accessible :name

  before_save { self.uname.downcase! }
  VALID_UNAME_REGEX = /\D+/
  validates :name, :presence => :true, :length => { :maximum => 150 }
  validates :uname, :format => { VALID_UNAME_REGEX }, :uniqueness => { :case_sensitive => false }
end