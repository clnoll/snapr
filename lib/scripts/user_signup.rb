require 'snapcat'

class Snapr::UserSignUp

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)

    # user = Snapcat::Client.new(input[:username])
    # snapuser = user.login(input[:password])

    # if not snapuser.data[:logged]

    #   return { :success? => false, :error => 'Get Snapchat login'}
    # end

    username = Snapr.orm.get_user(input[:username])
    if !username.nil?
      { :success? => false, :error => "Username is taken" }
    else
      username = Snapr.orm.create_user(input[:username], input[:password])
      return { :success? => true, :username => username }
    end

  end

end
