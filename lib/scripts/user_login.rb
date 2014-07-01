require 'snapcat'

class Snapr::UserLogin

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)

    # user = Snapcat::Client.new(input[:username])
    # snapuser = user.login(input[:password])

    # if snapuser.data[:logged] == false
    #   return { :success? => false, :error => 'Get Snapchat login'}
    # end

    username = Snapr.orm.get_user(input[:username])
    if username.nil?
      { :success? => false, :error => "Please sign up" }
    else
      username = Snapr.orm.get_user(input[:username])
      return { :success? => true, :username => username }
    end
  end

end
