class Job < ActiveRecord::Base
  include Tokenable

  has_many :job_locations, dependent: :destroy
  has_many :locations, through: :job_locations

  validates :title, :description, presence: true

end