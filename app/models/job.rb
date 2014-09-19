class Job < ActiveRecord::Base
  belongs_to :company
  has_many :favorites, dependent: :destroy
  has_many :seekers, through: :favorites
  has_many :requirements, dependent: :destroy
  has_many :skills, through: :requirements
end