input = open('input.txt').readlines(:chomp => true).map { |e| e.split('', 2) }

x, y = 0, 0
heading = 90 # N, E, S, W = 0, 90, 180, 270

input.each do |dir|
  instruction, magnitude = dir[0], dir[1].to_i

  case instruction
  when 'N'
    y += magnitude
  when 'E'
    x += magnitude
  when 'S'
    y -= magnitude
  when 'W'
    x -= magnitude
  when 'L'
    heading -= magnitude
  when 'R'
    heading += magnitude
  when 'F'
    case heading % 360
    when 0
      y += magnitude
    when 90
      x += magnitude
    when 180
      y -= magnitude
    when 270
      x -= magnitude
    else
      raise "Invalid heading?"
    end
  else
    raise "invalid instruction #{instruction}"
  end
end

puts "x: #{x}, y: #{y}, manhattan distance: #{x.abs + y.abs}"