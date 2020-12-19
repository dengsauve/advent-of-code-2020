input = open('input.txt').readlines(:chomp => true).map { |e| e.split('', 2) }

ship_x, ship_y = 0, 0
waypoint_x, waypoint_y = 10, 1

input.each do |dir|
  instruction, magnitude = dir[0], dir[1].to_i

  case instruction
  when 'N'
    waypoint_y += magnitude
  when 'E'
    waypoint_x += magnitude
  when 'S'
    waypoint_y -= magnitude
  when 'W'
    waypoint_x -= magnitude
  when 'L'
    case magnitude
    when 90
      waypoint_y, waypoint_x = waypoint_x, -waypoint_y
    when 180
      waypoint_x, waypoint_y = -waypoint_x, -waypoint_y
    when 270
      waypoint_y, waypoint_x = -waypoint_x, waypoint_y
    else
      raise "invalid magnitude to rotate the waypoint about the ship"
    end
  when 'R'
    case magnitude
    when 90
      waypoint_y, waypoint_x = -waypoint_x, waypoint_y
    when 180
      waypoint_x, waypoint_y = -waypoint_x, -waypoint_y
    when 270
      waypoint_y, waypoint_x = waypoint_x, -waypoint_y
    else
      raise "invalid magnitude to rotate the waypoint about the ship"
    end
  when 'F'
    ship_x += (waypoint_x * magnitude)
    ship_y += (waypoint_y * magnitude)
  else
    raise "invalid instruction #{instruction}"
  end
end

puts "x: #{ship_x}, y: #{ship_y}, manhattan distance: #{ship_x.abs + ship_y.abs}"