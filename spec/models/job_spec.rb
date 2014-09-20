require 'rails_helper'

RSpec.describe Job, :type => :model do

  subject {FactoryGirl.create(:job)}

  it "should have a valid factory" do
    expect(subject).to be_valid
  end

  it 'should validate presence of title' do
    job = Job.create({
      :location => 'San Francisco, CA',
      :category => 'Front End',
      :description => Faker::Lorem.words(30).join(' '),
      :how_to_apply => Faker::Lorem.words(10).join(' ')
    })
    expect(job.errors.size).to eql(1)
  end

  it 'should validate presence of location' do
    job = Job.create({
      :title => 'Front End Developer',
      :category => 'Front End',
      :description => Faker::Lorem.words(30).join(' '),
      :how_to_apply => Faker::Lorem.words(10).join(' ')
    })
    expect(job.errors.size).to eql(1)
  end

  it 'should validate presence of description' do
    job = Job.create({
      :title => 'Front End Developer',
      :location => 'San Francisco, CA',
      :category => 'Front End',
      :how_to_apply => Faker::Lorem.words(10).join(' ')
    })
    expect(job.errors.size).to eql(1)
  end

  it 'should validate presence of how_to_apply' do
    job = Job.create({
      :title => 'Front End Developer',
      :location => 'San Francisco, CA',
      :category => 'Front End',
      :description => Faker::Lorem.words(30).join(' ')
    })
    expect(job.errors.size).to eql(1)
  end

  it 'should validate presence of category' do
    job = Job.create({
      :title => 'Front End Developer',
      :location => 'San Francisco, CA',
      :description => Faker::Lorem.words(30).join(' '),
      :how_to_apply => Faker::Lorem.words(10).join(' ')
    })
    expect(job.errors.size).to eql(2)
  end

  it 'should validate category format' do
    job = Job.create({
      :title => 'Front End Developer',
      :location => 'San Francisco, CA',
      :category => Faker::Lorem.words(2).join(' '),
      :description => Faker::Lorem.words(30).join(' '),
      :how_to_apply => Faker::Lorem.words(10).join(' ')
    })
    expect(job.errors.size).to eql(1)
  end

  it 'should geocode location' do
    expect(subject.latitude).not_to eql(nil)
    expect(subject.longitude).not_to eql(nil)
  end

  it 'should have many seekers' do
    example_seeker = FactoryGirl.create(:seeker)
    subject.seekers << example_seeker
    expect(subject.seekers.length).to eql(1)
    expect(example_seeker.jobs.length).to eql(1)
  end

  it 'should have many skills' do
    example_skill = FactoryGirl.create(:skill)
    subject.skills << example_skill
    expect(subject.skills.length).to eql(1)
    expect(example_skill.jobs.length).to eql(1)
  end

end