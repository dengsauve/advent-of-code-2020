input = open('./input.txt').readlines

def check_slope(y_inc, x_inc, input)
  y = 0
  x = 0
  hits = []

  (input.length - 1).times do
    y += y_inc # move down
    break if y >= input.length # check bounds
    x += x_inc # move right
    x = x % 31 # check bounds
    hits << [y, x] if input[y][x] == '#'
  end

  return hits.length
end

puts 'checking slope 1'
slope_one_hits = check_slope(1, 1, input)

puts 'checking slope 2' # this alone is part 1
slope_two_hits = check_slope(1, 3, input)
puts "\npart 1 result: #{slope_two_hits}\n\n"

puts 'checking slope 3'
slope_three_hits = check_slope(1, 5, input)

puts 'checking slope 4'
slope_four_hits = check_slope(1, 7, input)

puts 'checking slope 5'
slope_five_hits = check_slope(2, 1, input)

puts "\nPart 2 result: #{slope_one_hits * slope_two_hits * slope_three_hits * slope_four_hits * slope_five_hits}"
