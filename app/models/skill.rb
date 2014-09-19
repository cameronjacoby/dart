class Skill < ActiveRecord::Base
  has_many :requirements, dependent: :destroy
  has_many :jobs, through: :requirements
end