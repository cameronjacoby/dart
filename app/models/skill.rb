class Skill < ActiveRecord::Base

  has_many :requirements, dependent: :destroy
  has_many :jobs, through: :requirements

  validates :name,
    presence: :true,
    uniqueness: :true

end