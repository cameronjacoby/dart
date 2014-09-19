class User < ActiveRecord::Base
  has_one :seeker, dependent: :destroy
  has_one :company, dependent: :destroy

  has_secure_password
end