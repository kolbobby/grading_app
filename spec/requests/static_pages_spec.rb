require 'spec_helper'

describe "StaticPages" do
	describe "HomePage" do
		it "should have the h1 'Phys. Ed.'" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text => 'Phys. Ed.')
		end
		it "should have the title 'Home'" do
			visit '/static_pages/home'
			page.should have_selector('title', :text => 'Physical Education | Home')
		end
	end
	describe "HelpPage" do
		it "should have the h1 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('h1', :text => 'Help')
		end
		it "should have the title 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('title', :text => 'Physical Education | Help')
		end
	end
end
