input = open('./input.txt').readlines

def parse_line(line)
  tokens = line.split(': ')
  password = tokens[1]
  details = tokens[0].split(' ')
  bounds = details[0].split('-')
  character = details[1]

  return password, bounds, character
end

# Part 1
valid_pw_count = 0
input.each do | line |
  password, bounds, character = parse_line(line)
  count = password.count(character)
  valid_pw_count += 1 if count >= bounds[0].to_i and count <= bounds[1].to_i
end
puts valid_pw_count

# Part 2
valid_pw_count = 0
input.each do | line |
  password, bounds, character = parse_line(line)
  valid_pw_count += 1 if (password[bounds[0].to_i - 1] == character) ^ (password[bounds[1].to_i - 1] == character)
end
puts valid_pw_count
