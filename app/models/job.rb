class Job < ActiveRecord::Base
  validates :description, presence: true
end