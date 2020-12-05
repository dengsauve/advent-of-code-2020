input = open('./input.txt').readlines
input.map!(&:to_i)

target = 2020

input.each_with_index do |num1, i|
  break unless input.each_with_index do |num2, ii|
    unless i == ii
      if num1 + num2 == target
        puts num1, num2, num1 * num2, ''
        break
      end
    end
  end
end

input.each_with_index do |num1, i|
  input.each_with_index do |num2, ii|
    input.each_with_index do |num3, iii|
      unless i == ii or ii == iii or i == iii
        if num1 + num2 + num3 == target
          puts num1, num2, num3, num1 * num2 * num3
          exit
        end
      end
    end
  end
end


puts "no match found"