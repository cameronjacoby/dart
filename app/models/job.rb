class Job < ActiveRecord::Base

  belongs_to :company
  has_many :favorites, dependent: :destroy
  has_many :seekers, through: :favorites
  has_many :requirements, dependent: :destroy
  has_many :skills, through: :requirements

  validates :title, :location, :description, :how_to_apply,
    presence: :true

  validates :category,
    :format => {:with => /Full Stack|Front End|Back End|Mobile - iOS|Mobile - Android/}

  geocoded_by :location, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode

end