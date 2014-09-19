class Company < ActiveRecord::Base

  belongs_to :user
  has_many :jobs, dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: {case_sensitive: false}

  def get_crunchbase_path
    # use self.name for API call to get CrunchBase path
    # save CrunchBase path to self.path
  end

  def get_crunchbase_profile
    if self.crunchbase_path
      # API call to get CrunchBase profile
      # return CrunchBase profile
    end
  end

end