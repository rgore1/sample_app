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

class User < ActiveRecord::Base
  attr_accessor :name, :email, :password, :password_confirmation

  before_save { |user| user.email = email.downcase }
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token


  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}

  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  def authenticate
    password.equal?(password_confirmation)
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end

