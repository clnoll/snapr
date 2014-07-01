require 'snapcat'

class Snapr::SendSnap

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)

    # sender = Snapr::ORM.get_user(input[:username])
    # Snapr::UserLogin.run({ :username=> 'snaprtest', :password => 'Snaprpassword' })

    # recipient = Snapr::ORM.get_user(input[:username])

    # message = sender.send_media('/Users/catherinenoll/Dropbox/964148_10151951006908219_878025574_o (1) copy 2.jpg', recipient)



  #   profile = Snapr.orm.create_profile(input[:id], input[:age], input[:city], input[:state], input[:gender], input[:gender_pref], input[:description])

  #   if profile.id == nil
  #     return { :success? => false, :error => "Missing user id"}
  #   end

  #   { :success? => true, :profile => profile}
  end
end
