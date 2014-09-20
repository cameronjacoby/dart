require 'rails_helper'

RSpec.describe Company, :type => :model do

  subject {FactoryGirl.create(:company)}

  it "should have a valid factory" do
    expect(subject).to be_valid
  end

  it 'should validate presence of name' do
    company = Company.create({})
    expect(company.errors.size).to eql(1)
  end

  it 'should validate uniqueness of name' do
    Company.create({
      :name => 'General Assembly'
    })
    company = Company.create({
      :name => 'General Assembly'
    })
    expect(company.errors.size).to eql(1)
  end

  it 'should have many jobs' do
    example_job = FactoryGirl.create(:job)
    subject.jobs << example_job
    expect(subject.jobs.length).to eql(1)
    expect(example_job.company).to eql(subject)
  end

  # it 'should get path from CrunchBase API' do
  #   subject.get_crunchbase_path
  #   expect(subject.crunchbase_path).to eql('organization/general-assembly')
  # end

  # it 'should get CrunchBase profile if crunchbase_path exists' do
  #   expect(subject.get_crunchbase_profile).to be(nil)
  #   subject.get_crunchbase_path
  #   expect(subject.get_crunchbase_profile).not_to be(nil)
  # end

end