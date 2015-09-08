class Role < ActiveRecord::Base
  has_many :job_roles, dependent: :destroy
  has_many :jobs, through: :job_roles

  validates :slug,
    presence: true,
    uniqueness: true

end