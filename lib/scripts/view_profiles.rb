class Snapr::ViewProfiles

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)
    user = Snapr.orm.get_user_by_id(input[:id])

    profiles = Snapr.orm.list_potential(input[:id], user.gender_pref)

    if profiles.nil?
      return { :success? => false, :error => 'something terrible has happend' }
    end

    { :success? => true, :profiles => profiles }
  end
end
