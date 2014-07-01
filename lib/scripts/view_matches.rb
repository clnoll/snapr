class Snapr::ViewMatches

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)
    matches = Snapr.orm.list_matches(input[:uid])

    if matches.nil?
      return { :success? => false, :error => 'something terrible has happend' }
    end

    { :success? => true, :matches => matches }
  end
end
