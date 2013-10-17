# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  compteur        :integer          default(0)
#  first_name      :string(255)
#  last_name       :string(255)
#  zip_code        :string(255)
#  city            :string(255)
#  country         :string(255)
#  adress          :string(255)
#  phone           :string(255)
#

require 'spec_helper'

describe User do

  before do
    @user = FactoryGirl.create(:user)
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:stickers) }
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_stickers) } 
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:shared_stickers) } 
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }

  it { should be_valid }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should be_valid }
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

	describe "return value of authenticate method" do
	  before { @user.save }
	  let(:found_user) { User.find_by_email(@user.email) }

	  describe "with valid password" do
	    it { should == found_user.authenticate(@user.password) }
	  end

	  describe "with invalid password" do
	    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

	    it { should_not == user_for_invalid_password }
	    specify { user_for_invalid_password.should be_false }
	  end

	  describe "with a password that's too short" do
		  before { @user.password = @user.password_confirmation = "a" * 5 }
		  it { should be_invalid }
		end

    describe "remember token" do
      before { @user.save }
      its(:remember_token) { should_not be_blank }
    end
	end

  describe "stickers associations" do

    before { @user.save }
    let!(:older_sticker) do 
      FactoryGirl.create(:sticker, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_sticker) do
      FactoryGirl.create(:sticker, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right stickers in the right order" do
      @user.stickers.should == [newer_sticker, older_sticker]
    end

    it "should destroy associated stickers" do
      stickers = @user.stickers.dup
      @user.destroy
      stickers.should_not be_empty
      stickers.each do |sticker|
        Sticker.find_by_id(sticker.id).should be_nil
      end
    end

  end

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }   
    let(:sticker) { FactoryGirl.create(:sticker, user: other_user, created_at: 1.hour.ago) }    
    before do
      @user.save
      @user.follow!(other_user, sticker)
    end

    it { should be_following(sticker) }
    its(:followed_stickers) { should include(sticker) }

    describe "and unfollowing" do
      before { @user.unfollow!(sticker) }

      it { should_not be_following(sticker) }
      its(:followed_stickers) { should_not include(sticker) }
    end
  end


end
