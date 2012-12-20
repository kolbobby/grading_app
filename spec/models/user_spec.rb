require 'spec_helper'

describe User do
	before { @user = User.new(:name => "Example User") }
	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:uname) }
	it { should respond_to(:password_digest) }
	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end
	describe "when name is too long" do
		before { @user.name = "a" * 151 }
		it { should_not be_valid }
	end
	describe "name with mixed case" do
		let(:mixed_case_name) { "TeStIngAMIXedCasEName" }

		it "should be saved all lower-case" do
			@user.name = mixed_case_name
			@user.save
			@user.reload.name.should == mixed_case_name.downcase
		end
	end

	describe "when uname format is invalid" do
		it "should be invalid" do
			unames = %w[rkoller13 13rkoller rkoll3r rk0ller rk0ll3r]
			unames.each do |invalid_uname|
				@user.uname = invalid_uname
				@user.should_not be_valid
			end
		end
	end
end