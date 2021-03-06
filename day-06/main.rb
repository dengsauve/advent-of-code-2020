require '../lib/aoc-lib.rb'
input = open('./input.txt').read.split("\n\n")

count = 0
input.each do |group|
  count += group.without_newline.to_a.uniq.size
end
puts "part 1: #{count}"

count = 0
input.each do |group|
  bundle = group.without_newline.to_a
  bundle.uniq.each do |letter|
    count += 1 if bundle.count(letter) == group.count("\n") + 1
  end
end
puts "part 2: #{count}"