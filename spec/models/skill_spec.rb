require 'rails_helper'

RSpec.describe Skill, :type => :model do

  subject {FactoryGirl.create(:skill)}

  it "should have a valid factory" do
    expect(subject).to be_valid
  end

  it 'should validate presence of name' do
    skill = Skill.create({})
    expect(skill.errors.size).to eql(1)
  end

  it 'should validate uniqueness of name' do
    name = Faker::Lorem.words(2).join(' ')
    Skill.create({
      :name => name
    })
    skill = Skill.create({
      :name => name
    })
    expect(skill.errors.size).to eql(1)
  end

  it 'should have many jobs' do
    example_job = FactoryGirl.create(:job)
    subject.jobs << example_job
    expect(subject.jobs.length).to eql(1)
    expect(example_job.skills.length).to eql(1)
  end

end