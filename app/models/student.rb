class Student < ActiveRecord::Base
  attr_accessible :grade_level, :name, :period, :sign_in_teacher
end
