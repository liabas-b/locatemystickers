require 'spec_helper'

describe "User pages" do

 #  subject { page }

 #  describe "signup page" do
 #    before { visit signup_path }

 #    it { should have_selector('h1',    text: 'Sign up') }
 #    it { should have_selector('title', text: full_title('Sign up')) }
 #  end

 #  describe "profile page" do
	#   let(:user) { FactoryGirl.create(:user) }
	#   before { visit user_path(user) }

	#   it { should have_selector('title', text: user.name) }
	# end

	# describe "signup" do

 #    before { visit signup_path }

 #    let(:submit) { "Create my account" }

 #    describe "with invalid information" do
 #      it "should not create a user" do
 #        expect { click_button submit }.not_to change(User, :count)
 #      end
 #    end

 #    describe "with valid information" do
 #      before do
 #        fill_in "Name",         with: "Example User"
 #        fill_in "Email",        with: "user@example.com"
 #        fill_in "Password",     with: "foobar"
 #        fill_in "Confirmation", with: "foobar"
 #      end

 #      it "should create a user" do
 #        expect { click_button submit }.to change(User, :count).by(1)
 #      end
 #    end
 #  end

 #  describe "profile page" do
 #    let(:user) { FactoryGirl.create(:user) }
 #    let!(:m1) { FactoryGirl.create(:sticker, user: user, name: "Foo") }
 #    let!(:m2) { FactoryGirl.create(:sticker, user: user, name: "Bar") }

 #    before { visit user_path(user) }

 #    it { should have_selector('title', text: user.name) }

 #    describe "stickers" do
 #      it { should have_content(m1.name) }
 #      it { should have_content(m2.name) }
 #      it { should have_content(user.stickers.count) }
 #    end
 #  end

 #  pending "edit page" do
 #    let(:user) { FactoryGirl.create(:user) }
 #    before { visit edit_user_path(user) }

 #    subject { page }

 #    describe "page" do
 #      it { should have_selector('h1',    text: "Update your profile") }
 #      it { should have_selector('title', text: "Edit user") }
 #      it { should have_link('change gravatar', href: 'http://gravatar.com/emails') }
 #    end

 #    describe "with invalid information" do
 #      before { click_button "Save Changes" }

 #      it { should have_content('error') }
 #    end

 #    describe "delete links" do

 #      it { should_not have_link('X') }

 #      describe "as an admin user" do
 #        let(:admin) { FactoryGirl.create(:admin) }
 #        before do
 #          sign_in admin
 #          visit users_path
 #        end

 #        it { should have_link('X', href: user_path(User.first)) }
 #        it "should be able to delete another user" do
 #          expect { click_link('X') }.to change(User, :count).by(-1)
 #        end
 #        it { should_not have_link('X', href: user_path(admin)) }
 #      end
 #    end
 #  end
end