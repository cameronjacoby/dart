class Company < ActiveRecord::Base

  belongs_to :user
  has_many :jobs, dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: {case_sensitive: false}

  def get_crunchbase_path
    # use self.name for API call to get CrunchBase path
    request = Typhoeus.get(
      'http://api.crunchbase.com/v/2/organizations',
      :params => {
        :user_key => ENV['CRUNCHBASE_USER_KEY'],
        :name => self.name,
        :organization_types => "company"
      }
    )
    response = JSON.parse(request.body)
    # choose 1st company in response
    # save path to self.crunchbase_path
    if response
      self.crunchbase_path = response['data']['items'][0]['path']
    end
  end

  def get_crunchbase_profile
    if self.crunchbase_path
      # use self.crunchbase_path for API call to get CrunchBase profile
      request = Typhoeus.get(
        'http://api.crunchbase.com/v/2/' + self.crunchbase_path,
        :params => {
          :user_key => ENV['CRUNCHBASE_USER_KEY']
        }
      )
      response = JSON.parse(request.body)
      # return CrunchBase profile
      response['data']
    end
  end

end