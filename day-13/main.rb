input = open('input.txt').readlines(:chomp => true)

# input = [nil, '1789,37,47,1889']

query_string = ''

alpha = 'a'

input[1].split(',').each_with_index do |e, i|
  unless e == 'x'
    query_string += "#{e}#{alpha} - #{i} = "
    alpha.next!
  end
end

puts query_string

# Dump that bitch into WA 😂, multiply modifier by {whatever number was paired with 'a'} i.e. 19a