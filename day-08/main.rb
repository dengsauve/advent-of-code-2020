input = open('input.txt').readlines.map { |e| e.gsub!("\n", ''); e.split(' ') }
@accumulator = 0

def part_1(input)
  indexes = []
  index = 0

  while indexes.size == indexes.uniq.size
    indexes << index

    puts "!!repeat!!" if indexes.size != indexes.uniq.size

    puts "index: #{index}", "command: #{input[index]}"

    case input[index][0]
    when 'acc'
      @accumulator = eval(@accumulator.to_s + input[index][1])
      index += 1
    when 'jmp'
      index = eval(index.to_s + input[index][1])
    when 'nop'
      index += 1
      next
    else
      raise "invalid command at #{index}"
    end

    puts "accumulator: #{@accumulator}" #176, 71 are wrong, 1577

  end
end

def part_2(input)
  index = 0
  swapped_indexes = [] # array of indexes that have been tried

  until index == input.size
    index = 0
    indexes = []
    swapped = false
    @accumulator = 0

    while indexes.size == indexes.uniq.size
      indexes << index

      puts "!!repeat!!" if indexes.size != indexes.uniq.size

      # puts "index: #{index}", "command: #{input[index]}"

      if index == input.size
        puts "that was it: #{@accumulator}"
        exit
      end

      case input[index][0]
      when 'acc'
        @accumulator = eval(@accumulator.to_s + input[index][1])
        index += 1
      when 'jmp'
        if swapped == false and !swapped_indexes.include?(index)
          puts "trying: #{index} as jpm to nop"
          swapped_indexes << index
          swapped = true
          index += 1
        else
          index = eval(index.to_s + input[index][1]) # nop cmd swap
        end
      when 'nop'
        if swapped == false and !swapped_indexes.include?(index)
          puts "trying: #{index} as npm to jpm"
          swapped = true
          swapped_indexes << index
          index = eval(index.to_s + input[index][1]) # jpm cmd swap
        else
          index += 1
          next
        end
      else
        raise "invalid command at #{index}"
      end

    end

    puts "accumulator: #{@accumulator}" # 21024 are wrong

  end
  # need to include all the indexes from part_one
end

part_1(input)
@accumulator = 0
part_2(input)