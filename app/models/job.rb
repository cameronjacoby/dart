class Job < ActiveRecord::Base
  include Tokenable
  validates :description, presence: true
end