class Job < ActiveRecord::Base
  belongs_to :company
  has_many :favorites, dependent: :destroy
  has_many :seekers, through: :favorites
end