require 'spec_helper'

describe "StaticPages" do
	let(:base_title) { "Physical Education" }
	describe "HomePage" do
		it "should have the h1 'Phys. Ed.'" do
			visit root_path
			page.should have_selector('h1', :text => 'Phys. Ed.')
		end
		it "should have the base title" do
			visit root_path
			page.should have_selector('title', :text => "#{base_title}")
		end
		it "should not have a custom page title" do
			visit root_path
			page.should_not have_selector('title', :text => ' | Home')
		end
	end
	describe "HelpPage" do
		it "should have the h1 'Help'" do
			visit help_path
			page.should have_selector('h1', :text => 'Help')
		end
		it "should have the title 'Help'" do
			visit help_path
			page.should have_selector('title', :text => "#{base_title} | Help")
		end
	end
end
