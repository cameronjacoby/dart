class Job < ActiveRecord::Base

  belongs_to :company
  has_many :favorites, dependent: :destroy
  has_many :seekers, through: :favorites
  has_many :requirements, dependent: :destroy
  has_many :skills, through: :requirements

  validates :title, :location, :description, :how_to_apply,
    presence: :true

  validates :category,
    presence: :true,
    :format => {:with => /Full Stack|Front End|Back End|Mobile - iOS|Mobile - Android|Other/}

  geocoded_by :location, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode

  def increase_clicks
    self.clicks += 1
    self.save
  end

end