class User < ActiveRecord::Base

  has_one :seeker, dependent: :destroy
  has_one :company, dependent: :destroy

  has_secure_password

  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    :format => {:with => /\A[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})\z/}
  
  validates :password,
    presence: true,
    confirmation: true,
    length: {minimum: 6}

end