# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string
#

require 'rails_helper'
require 'spec_helper'
require 'coffee_script'

RSpec.describe User do

  subject { @user }

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  it { expect(@user).to respond_to(:name) }
  it { expect(@user).to respond_to(:email) }
  it { expect(@user).to respond_to(:password_digest) }
  it { expect(@user).to respond_to(:password) }
  it { expect(@user).to respond_to(:password_confirmation) }
  it { expect(@user).to be_valid }


  describe "when name is not present" do
    before { @user.name = " " }
    it { expect(@user).to_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { expect(@user).to_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { expect(@user).to_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user at foo.org example.user@foo. foo@bar baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.dup
    end
    it { expect(@user).to_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { expect(@user).to_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { expect(@user).to_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { expect(@user).to_not be_valid }
  end

  describe "return value of authenticate method" do

    before { @user.save }

    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { expect(@user).to be(found_user.authenticate(@user.password)) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it { expect(@user).to user_for_invalid_password }
      specify { expect(user_for_invalid_password).to false }
    end

    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { expect(@user).to_not be_valid }
    end

  end


end
