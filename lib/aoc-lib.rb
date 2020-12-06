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