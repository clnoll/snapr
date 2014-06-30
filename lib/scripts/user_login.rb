class Snapr::UserLogin

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)

    user = Snapcat::Client.new(input[:username])
    if user.nil?
      return { :success? => false, :error => 'Get snapchat login'}
    end
    user.login(input[:password])

    username = Snapr.orm.get_user(input[:username])

  #   if username.nil?
  #     username = Snapr.orm.create_user(input[:username], input[:password])
  #     return { :success? => true, :username => username }
  #   end

  #   { :success? => false, :error => "Username is taken" }

  #   end
  end

end
