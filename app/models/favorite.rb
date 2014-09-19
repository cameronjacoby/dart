class Favorite < ActiveRecord::Base
  belongs_to :seeker
  belongs_to :job
end