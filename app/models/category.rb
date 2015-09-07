class Category < ActiveRecord::Base
  has_many :job_categories, dependent: :destroy
  has_many :jobs, through: :job_categories
end