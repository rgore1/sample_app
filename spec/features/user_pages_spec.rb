require 'rails_helper'
require 'spec_helper'
require 'coffee_script'

describe "User pages" do

  subject { page }

  describe "signup page" do

    before { visit signup_path }
    it { expect(page).to have_selector('h1', text: 'Sign up') }
    it { expect(page).to have_selector('title', text: 'Sign up') }
  end

end
