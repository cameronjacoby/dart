class Seeker < ActiveRecord::Base

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :jobs, through: :favorites

  validates :first_name, :last_name,
    presence: true

  def add_favorite job
    self.jobs << job
  end

  def remove_favorite job
    self.jobs.delete(job)
  end

end