require 'rails_helper'

RSpec.describe User, :type => :model do

  subject {FactoryGirl.create(:user)}

  it "should have a valid factory" do
    expect(subject).to be_valid
  end

  it 'should validate presence of email' do
    pswrd = Faker::Lorem.words(4).join('')
    user = User.create({
      :password => pswrd,
      :password_confirmation => pswrd
    })
    expect(user.errors.size).to eql(2)
  end

  it 'should validate uniqueness of email' do
    email = Faker::Internet.email
    pswrd = Faker::Lorem.words(4).join('')
    User.create({
      :email => email,
      :password => pswrd,
      :password_confirmation => pswrd
    })
    user = User.create({
      :email => email,
      :password => pswrd,
      :password_confirmation => pswrd
    })
    expect(user.errors.size).to eql(1)
  end

  it 'should validate email format' do
    pswrd = Faker::Lorem.words(4).join('')
    user = User.create({
      :email => 'cameron@gmail',
      :password => pswrd,
      :password_confirmation => pswrd
    })
    expect(user.errors.size).to eql(1)
  end

  it 'should validate presence of password' do
    user = User.create({
      :email => Faker::Internet.email
    })
    expect(user.errors.size).to eql(3)
  end

  it 'should require password confirmation' do
    user = User.create({
      :email => Faker::Internet.email,
      :password => Faker::Lorem.words(4).join(''),
      :password_confirmation => Faker::Lorem.words(4).join('')
    })
    expect(user.errors.size).to eql(2)
  end

  it 'should validate password length' do
    user = User.create({
      :email => Faker::Internet.email,
      :password => '123',
      :password_confirmation => '123'
    })
    expect(user.errors.size).to eql(1)
  end

  it 'should have one seeker' do
    example_seeker = FactoryGirl.create(:seeker)
    subject.seeker = example_seeker
    expect(subject.seeker.user_id).to eql(subject.id)
    expect(example_seeker.user).to eql(subject)
  end

  it 'should have one company' do
    pswrd = Faker::Lorem.words(4).join('')
    user = User.create({
      :email => Faker::Internet.email,
      :password => pswrd,
      :password_confirmation => pswrd,
      :is_company? => true
    })
    example_company = FactoryGirl.create(:company)
    user.company = example_company
    expect(user.company.user_id).to eql(user.id)
    expect(example_company.user).to eql(user)
  end

end