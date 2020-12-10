input = open('input.txt').readlines

def get_box_area(l, w, h)
  (2 * l * w) + (2 * w * h) + (2 * h * l)
end

def get_slack(dims)
  dims[0] * dims[1]
end

total_square_feet = 0

input.each do |dims|
  dims = dims.split('x').map { |e| e.to_i }
  total_square_feet += get_box_area(*dims)
  total_square_feet += get_slack(dims.sort)
end

puts total_square_feet # 1440710 too low