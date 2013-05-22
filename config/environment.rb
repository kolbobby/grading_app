# Load the rails application
ENV['RAILS_ENV'] ||= 'production'
require File.expand_path('../application', __FILE__)
require 'will_paginate'

# Initialize the rails application
GradingApp::Application.initialize!
