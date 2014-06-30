class Snapr::RateProfile

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)
    liked = Snapr.orm.insert_match
  end
end
