class User < ActiveRecord::Base
  has_secure_password

  validates :email,
    presence: true,
    uniqueness: true,
    format: {
      with: /@/,
      message: "not a valid format"
    }

  validates :password,
    length: { minimum: 6 }, on: :create

  def self.from_oauth oauth
    oauth.get_data
    data = oauth.data
    user = find_by(oauth.provider => data[:id]) || find_or_create_by(email: data[:email]) do |u|
      u.password =  SecureRandom.hex
    end
    user.update(
      email: data[:email],
      oauth.provider => data[:id]
    )
    user
  end

end