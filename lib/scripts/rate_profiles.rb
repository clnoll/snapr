class Snapr::RateProfile

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)
    liked = Snapr.orm.insert_match(input[:uid], input[:uid_2], input[:like])

    if liked == true
      return { :success? => true, :result => true }
    elsif liked == false
      return { :success? => true, :result => false }
    end

    { :success? => false, :error => 'something terrible has happend' }
  end
end
