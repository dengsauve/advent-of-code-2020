# String Class Extensions
class String
  def without_newline
    self.gsub("\n", '')
  end

  def numeric?
    Float(self) != nil rescue false
  end

  def to_a
    self.chars.to_a
  end
end

# Array Class Extensions
class Array
  def first_half
    self.each_slice( (self.size/2.0).round ).to_a[0]
  end
  def second_half
    self.each_slice( (self.size/2.0).round ).to_a[1]
  end
end