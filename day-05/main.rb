input = open('./input.txt').readlines
ids = []

input.each do |pass|
  rows = (0..127)
  cols = (0..7)

  (0..6).each do |index|
    operator = pass[index]

    if operator == 'F'
      rows = rows.each_slice( (rows.size/2.0).round ).to_a[0]
    elsif operator == 'B'
      rows = rows.each_slice( (rows.size/2.0).round ).to_a[1]
    end
  end

  row = rows[0]

  (7..9).each do |index|
    operator = pass[index]

    if operator == 'L'
      cols = cols.each_slice( (cols.size/2.0).round ).to_a[0]
    elsif operator == 'R'
      cols = cols.each_slice( (cols.size/2.0).round ).to_a[1]
    end
  end

  col = cols[0]
  ids << (row * 8 + col)
end

puts ids.max
ids.sort!

(0..(ids.size - 2)).each do |index|
  if ids[index] == ids[index + 1] - 2
    puts "#{ids[index] + 1} Should be between #{ids[index]} and #{ids[index + 1]}"
    exit
  end
end