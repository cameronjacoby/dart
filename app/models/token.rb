class Token
  attr_reader :user_id, :payload

  def initialize token
    @payload = JWT.decode(token, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM']).first.with_indifferent_access
    @user_id = @payload[:user_id]
  rescue JWT::DecodeError
    nil
  end

  def valid?
    user_id.presence && Time.now < Time.at(@payload[:exp].to_i)
  end

  def self.encode user_id
    JWT.encode({ user_id: user_id, exp: (DateTime.now + 30).to_i }, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])
  end

end