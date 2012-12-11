require 'spec_helper'

describe "StaticPages" do
	let(:base_title) { "Physical Education" }
	describe "HomePage" do
		it "should have the h1 'Phys. Ed.'" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text => 'Phys. Ed.')
		end
		it "should have the base title" do
			visit '/static_pages/home'
			page.should have_selector('title', :text => "#{base_title}")
		end
		it "should not have a custom page title" do
			visit '/static_pages/home'
			page.should_not have_selector('title', :text => ' | Home')
		end
	end
	describe "HelpPage" do
		it "should have the h1 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('h1', :text => 'Help')
		end
		it "should have the title 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('title', :text => "#{base_title} | Help")
		end
	end
end
