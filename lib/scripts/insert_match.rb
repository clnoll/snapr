class Snapr::InsertMatch

  def self.run(inputs)
    self.new.run(inputs)
  end

  def run(input)


    matches = Snapr.orm.insert_match(input['user'], input['uid_2'], input['match'])

    if matches.nil?
      return { :success? => false, :error => 'something terrible has happend' }
    end

    { :success? => true, :matches => matches }
  end
end
