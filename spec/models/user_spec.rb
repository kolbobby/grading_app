require 'spec_helper'

describe User do
	before { @user = User.new(:name => "Example User") }
	subject { @user }

	it { should respond_to(:name) }
	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end
	describe "when name is too long" do
		before { @user.name = "a" * 151 }
		it { should_not be_valid }
	end
	describe "when name is already in database" do
		before do
			student_with_same_name = @user.dup
			student_with_same_name.name = @user.name.upcase
			student_with_same_name.save
		end
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
end