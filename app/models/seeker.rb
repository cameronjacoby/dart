class Seeker < ActiveRecord::Base
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :jobs, through: :favorites
end