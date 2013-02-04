class Student < ActiveRecord::Base
  attr_accessible :grade_level, :name, :period, :sign_in_teacher

  validates :name, :presence => true
  validates :period, :presence => true
  validates :grade_level, :presence => true
  validates :sign_in_teacher, :presence => true
end