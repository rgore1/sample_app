class Micropost < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user

  validates :user_id, presence: true,  length: {maximum: 140}

  default_scope { order('microposts.created_at') }
end
