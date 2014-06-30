class Snapr::User
  attr_reader :username, :password, :id, :age, :city, :state, :gender, :gender_pref, :description

  def initialize(username, password, id, options = {})
    @username = username
    @password = password
    @id = id
    @age = options['age'] ||= nil
    @city = options['city'] ||= nil
    @state = options['state'] ||= nil
    @gender = options['gender'] ||= nil
    @gender_pref = options['gender_pref'] ||= nil
    @description = options['description'] ||= nil
  end
end
