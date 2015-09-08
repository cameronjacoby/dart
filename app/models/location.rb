class Location < ActiveRecord::Base
  has_many :job_locations, dependent: :destroy
  has_many :jobs, through: :job_locations

  geocoded_by :city, latitude: :latitude, longitude: :longitude
  after_validation :geocode, if: lambda { |obj| obj.city_changed? }

  validates :slug,
    presence: true,
    uniqueness: true

end