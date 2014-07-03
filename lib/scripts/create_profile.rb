require 'snapcat'

class Snapr::CreateProfile

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)

    profile = Snapr.orm.create_profile(input['id'], input['age'], input['city'], input['state'], input['gender'], input['gender_pref'], input['description'], input['image'])

    if profile.id == nil
      return { :success? => false, :error => "Missing user id"}
    end

    { :success? => true, :profile => profile}
  end
end
