require 'rails_helper'

RSpec.describe Seeker, :type => :model do

  subject {FactoryGirl.create(:seeker)}

  it "should have a valid factory" do
    expect(subject).to be_valid
  end

  it 'should validate presence of first_name' do
    seeker = Seeker.create({
      :last_name => 'Jacoby'
    })
    expect(seeker.errors.size).to eql(1)
  end

  it 'should validate presence of last_name' do
    seeker = Seeker.create({
      :first_name => 'Cameron'
    })
    expect(seeker.errors.size).to eql(1)
  end

  it 'should have many jobs' do
    example_job = FactoryGirl.create(:job)
    subject.jobs << example_job
    expect(subject.jobs.length).to eql(1)
    expect(example_job.seekers.length).to eql(1)
  end

end