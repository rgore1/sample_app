require 'rails_helper'
require 'spec_helper'
require 'coffee_script'


describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }
    it { should have_selector('h1', text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do

      before { click_button "Sign in" }
      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

    describe "with valid information" do

      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      describe "after visiting another page" do
        before { click_link "Home" }
        it { expect(page).to_not have_selector('div.alert.alert-error') }
      end

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { expect(page).not_to have_link('Sign in', href: signin_path) }

    end
  end
end
