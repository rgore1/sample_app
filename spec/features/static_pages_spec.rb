require 'rails_helper'
require 'spec_helper'
require 'coffee_script'

RSpec.describe 'StaticPages', type: :request do

  subject { page }

  describe "Home page" do

    before { visit root_path }

    it { expect(page).to have_selector('h1', text: 'Sample App') }
    it { expect(page).to have_selector 'title', text: full_title('') }

  end


  describe 'Help page' do

    before { visit help_path }

    it { expect(page).to have_selector('h1', text: 'Help') }
    it { expect(page).to have_selector('title', text: full_title('Help')) }

  end


  describe 'About page' do

    before { visit about_path }

    it { expect(page).to have_selector('h1', text: 'About') }
    it { expect(page).to have_selector('title', text: full_title('About Us')) }

  end


  describe "Contact page" do

    before { visit contact_path }

    it { expect(page).to have_selector('h1', text: 'Contact') }
    it { expect(page).to have_selector('title', text: full_title('Contact')) }

  end

end
