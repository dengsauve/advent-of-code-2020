input = open('input.txt').readlines

def get_box_area(l, w, h)
  (2 * l * w) + (2 * w * h) + (2 * h * l)
end

def get_box_volume(l, w, h)
  l * w * h
end

def get_slack(dims)
  dims.sort!
  dims[0] * dims[1]
end

def get_box_short_perimeter(dims)
  dims.sort!
  (2 * dims[0]) + (2 * dims[1])
end

total_square_feet = 0

input.each do |dims|
  dims = dims.split('x').map { |e| e.to_i }
  total_square_feet += get_box_area(*dims)
  total_square_feet += get_slack(dims)
end

puts total_square_feet # 1440710 too low

ribbon_needed = 0

input.each do |dims|
  dims = dims.split('x').map { |e| e.to_i }
  ribbon_needed += get_box_short_perimeter(dims)
  ribbon_needed += get_box_volume(*dims)
end

puts ribbon_needed