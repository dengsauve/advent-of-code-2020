input = "16,10,15,5,1,11,7,19,6,12,4"
# input = "28,33,18,42,31,14,46,20,48,47,24,23,49,45,19,38,39,11,1,32,25,35,8,17,7,9,4,2,34,10,3"
input = input.split(',').map { |e| e.to_i }.sort.unshift(0)
# input = open('input.txt').readlines.map { |e| e.to_i }.sort.unshift(0)

input.append(input[-1] + 3)

puts input

ones = 0
threes = 0


input.each_with_index do |e, i|
  break if i == input.size - 1
  threes += 1 if input[i + 1] - e == 3
  ones += 1 if input[i + 1] - e == 1
end

puts "ones: #{ones}", "threes: #{threes}", "product: #{ones * threes}"

# Shamelessly lifted part two from solutions megathread
# going to learn about DP/recursion for this tomorrow: answer was 13816758796288
# 8 and 19208 for the two test inputs, respectively