class Snapr::ViewProfiles

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)
    profiles = Snapr.orm.list_potential(input[:uid], input[:g_pref])

    if profiles.nil?
      return { :success? => false, :error => 'something terrible has happend' }
    end

    { :success? => true, :profiles => profiles }
  end
end
