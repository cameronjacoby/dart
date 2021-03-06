class Job < ActiveRecord::Base
  include Tokenable

  has_many :job_roles, dependent: :destroy
  has_many :roles, through: :job_roles
  has_many :job_locations, dependent: :destroy
  has_many :locations, through: :job_locations
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  validates :title, :description,
    presence: true
  
  validates :guid,
    uniqueness: true

  scope :active, proc { where active: true }

end