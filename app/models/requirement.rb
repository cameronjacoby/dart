class Requirement < ActiveRecord::Base
  belongs_to :job
  belongs_to :skill
end