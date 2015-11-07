class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = 0

    self.each_with_index do |el, idx|
      hash += el.hash * 5 * idx
    end

    hash
  end

end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  def hash
    self.each_key.sort.map(&:to_s).map(&:ord).hash
  end
end
