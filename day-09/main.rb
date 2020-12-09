input = open('input.txt').readlines.map { |e| e.to_i }

def check_sum(sum, array)
  array.each do |a|
    array.each do |b|
      return true if a + b == sum
    end
  end
  false
end

invalid_number = nil

input.each_with_index do |sum, index|
  if index >= 25
    range = input[(index - 25)..(index - 1)]
    raise "invalid size #{range.size} on #{index}" unless range.size == 25

    unless check_sum(sum, range)
      puts "invalid number: #{sum}"
      invalid_number = sum
      break
    end

  end
end

range = []

input.each_with_index do |num, index|
  (input.size - index - 1).times do |i|
    num += input[index + i + 1]
    if num == invalid_number
      puts "index range: #{index} - #{index + i + 1}\nnum: #{num}"
      range = input[(index)..(index + i + 1)]
      break
    end

  end
end

puts "encryption weakness: #{range.minmax.sum}" # not 117378467788482