input = open('input.txt').readlines.map { |e| e.split('') }

# N.B. test input doesn't quite match how the question says it will proceed. idk 2299

input = "L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL".split("\n").map { |e| e.split('') }


def array_as_grid(input)
  input.each { |row| puts row.join('') }
  puts
end


def cell_empty?(array, row, cell)
  (-1..1).each do |i|
    next unless array[row + i] and (row + i) >= 0
    (-1..1).each do |ii|
      next unless (cell + ii) >= 0
      next if i == 0 and ii == 0
      return false if array[row + i][cell + ii] == '#'
    end
  end
  true
end


def cell_appear_empty?(array, row, cell)
  # Check up and down
  (0..(array.size - 1)).each do |i|
    return false if array[i][cell] == '#' and i != row
    break if array[i][cell] == 'L' and i != row
  end

  # Check right and left
  (0..(array[0].size - 1)).each do |i|
    return false if array[row][i] == '#' and i != cell
    break if array[row][i] == 'L' and i != row
  end

  # Check up-right
  i, ii = row - 1, cell + 1
  while array[i] and array[i][ii]
    return false if array[i][ii] == '#'
    break if array[i][ii] == 'L'
    i += -1 # up
    ii += 1 # right
  end

  # Check down-right
  i, ii = row + 1, cell + 1
  while array[i] and array[i][ii]
    return false if array[i][ii] == '#'
    break if array[i][ii] == 'L'
    i += 1 # down
    ii += 1 # right
  end

  # Check down-left
  i, ii = row + 1, cell - 1
  while array[i] and array[i][ii]
    return false if array[i][ii] == '#'
    break if array[i][ii] == 'L'
    i += 1 # down
    ii += -1 # left
  end

  # check up-left
  i, ii = row - 1, cell - 1
  while array[i] and array[i][ii]
    return false if array[i][ii] == '#'
    break if array[i][ii] == 'L'
    i += -1 # up
    ii += -1 # left
  end

  true
end


def cell_crowded?(array, row, cell)
  count = 0
  (-1..1).each do |i|
    next unless array[row + i] and (row + i) >= 0
    (-1..1).each do |ii|
      next unless (cell + ii) >= 0
      next if i == 0 and ii == 0
      count += 1 if array[row + i][cell + ii] == '#'
    end
  end

  count >= 4
end


def cell_appear_crowded?(array, row, cell)
  count = 0

  # Check up
  i = row - 1
  while array[i] and array[i][cell]
    count += 1 if array[i][cell] == '#'
    break if array[i][cell] == 'L'
    i += -1 # up
  end

  # Check down
  i = row + 1
  while array[i] and array[i][cell]
    count += 1 if array[i][cell] == '#'
    break if array[i][cell] == 'L'
    i += 1 # down
  end

  # Check right
  ii = cell + 1
  while array[row] and array[row][ii]
    count += 1 if array[row][ii] == '#'
    break if array[row][ii] == 'L'
    ii += 1 # down
  end

  # Check left
  ii = cell - 1
  while array[row] and array[row][ii]
    count += 1 if array[row][ii] == '#'
    break if array[row][ii] == 'L'
    ii += -1 # down
  end

  # Check up-right
  i, ii = row - 1, cell + 1
  while array[i] and array[i][ii]
    count += 1 if array[i][ii] == '#'
    break if array[i][ii] == 'L'
    i += -1 # up
    ii += 1 # right
  end

  # Check down-right
  i, ii = row + 1, cell + 1
  while array[i] and array[i][ii]
    count += 1 if array[i][ii] == '#'
    break if array[i][ii] == 'L'
    i += 1 # down
    ii += 1 # right
  end

  # Check down-left
  i, ii = row + 1, cell - 1
  while array[i] and array[i][ii]
    count += 1 if array[i][ii] == '#'
    break if array[i][ii] == 'L'
    i += 1 # down
    ii += -1 # left
  end

  # check up-left
  i, ii = row - 1, cell - 1
  while array[i] and array[i][ii]
    count += 1 if array[i][ii] == '#'
    break if array[i][ii] == 'L'
    i += -1 # up
    ii += -1 # left
  end

  count >= 5
end


def part_one(input)
  a = input.map(&:clone)
  b = []


  first = true

  # array_as_grid(a)

  until a == b
    b = a.map(&:clone) if first
    a = b.map(&:clone) unless first

    a.each_with_index do |row, i|
      row.each_with_index do |cell , ii|
        if cell == 'L'
          # check surrounding cells for ANY occupied seats (8), -> # if none
          b[i][ii] = '#' if cell_empty?(a, i, ii)
        elsif cell == '#'
          # check surrounding cells for 4 or more occupied seats, -> L if >= 4
          b[i][ii] = 'L' if cell_crowded?(a, i, ii)
        end
      end
    end

    # array_as_grid(a)
    # array_as_grid(b)
    # puts b == a
    # gets
    first = false
  end

  a.flatten.count('#')
end


# piffle
def part_two(input)
  a = input.map(&:clone)
  b = []

  first = true

  # array_as_grid(a)

  until a == b
    b = a.map(&:clone) if first
    a = b.map(&:clone) unless first

    a.each_with_index do |row, i|
      row.each_with_index do |cell , ii|
        if cell == 'L'
          # check surrounding cells for ANY occupied seats (8), -> # if none
          b[i][ii] = '#' if cell_appear_empty?(a, i, ii)
        elsif cell == '#'
          # check surrounding cells for 4 or more occupied seats, -> L if >= 4
          b[i][ii] = 'L' if cell_appear_crowded?(a, i, ii)
        end
      end
    end

    # array_as_grid(a)
    array_as_grid(b)
    puts b == a
    gets
    first = false
  end

  a.flatten.count('#')
end

# puts part_one(input)

puts part_two(input)