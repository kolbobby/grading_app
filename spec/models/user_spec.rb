require 'spec_helper'

describe User do
	before do
		@user = User.new(:name => "Example User", :uname => "euser", :password => "foobar", :password_confirmation => "foobar")
	end
	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:uname) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
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

	describe "when uname is already taken" do
		before do
			user_with_same_uname = @user.dup
			user_with_same_uname.uname = @user.uname.upcase
			user_with_same_uname.save
		end
		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end
	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end
	describe "when password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end
	describe "when password is too short" do
		before { @user.password = @user.password_confirmation = "a" * 3 }
		it { should be_invalid }
	end

	describe "return value of authentication method" do
		before { @user.save }
		let(:found_user) { User.find_by_uname(@user.uname) }

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end
		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }
			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end
end