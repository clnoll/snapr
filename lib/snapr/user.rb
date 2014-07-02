class Snapr::User
  attr_reader :username, :password, :id, :age, :city, :state, :gender, :gender_pref, :description, :image

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
    @image = options['image'] ||= nil
  end

  def to_json
    return {
      username: @username,
      password: @password,
      id: @id,
      age: @age,
      city: @city,
      state: @state,
      gender: @gender,
      gender_pref: @gender_pref,
      description: @description
    }
  end
end
