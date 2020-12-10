input = open('input.txt').read.split('')

puts input.inspect

puts input.count('(') - input.count(')')

level = 0
input.each_with_index do |p, i|
  level += 1 if p == '('
  level -= 1 if p == ')'
  if level < 0
    puts i + 1
    exit
  end
end