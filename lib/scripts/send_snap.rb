require 'open-uri'
require 'net/http'
require 'snapcat'

class Snapr::SendSnap

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)

    sender = Snapr.orm.get_user_by_id(input['user'])
    recipient = Snapr.orm.get_user_by_id(input['uid_2'])

    user = Snapcat::Client.new(sender.username)
    snap_user = user.login(sender.password)
    # binding.pry

    create_snap = File.write('public/img/temp.jpg', Net::HTTP.get(URI.parse(input['snap'])))
# binding.pry
    sent = user.send_media(File.read('public/img/temp.jpg'), recipient.username)
    # binding.pry
    { :success? => true, :recipient => recipient}
  end
end
