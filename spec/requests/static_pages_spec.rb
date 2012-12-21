require 'spec_helper'

describe "StaticPages" do
	subject { page }

	describe "HomePage" do
		before { visit root_path }

		it { should have_selector('h1', :text => 'Phys. Ed.') }
		it { should_not have_selector('title', :text => ' | Home') }
	end
	describe "HelpPage" do
		before { visit help_path }

		it { should have_selector('h1', :text => 'Help') }
		it { should have_selector('title', :text => 'Help') }
	end
end