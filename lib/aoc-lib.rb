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

# Custom Methods

############################################################
# Sum Hunter (quotient, product, and diff can be derived)
#
# Given an array and target, this method will try to find
# a set of contiguous numbers from the array that total the
# target. The first set of numbers to match this criteria is
# returned in an array. If no set is found, an empty array
# is returned.
#
# @param |Array| array
# @param |Int| target
def sum_hunter(array, target)
  range = []
  array.each_with_index do |num, index|
    (array.size - 1 - index).times do |i|
      num += array[index + i + 1]
      if num == target
        range = array[(index)..(index + i + 1)]
        break
      end
    end
  end
  range
end