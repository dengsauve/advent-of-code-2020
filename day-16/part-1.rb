input = open('input.txt').readlines
# parse out three instruction chunks
input = input.chunk{ |item| item == "\n" }
	.reject{ |is_new_line, item_arr| is_new_line }
	.map{ |item_arr| item_arr[1] }

# PART 1

## read in the parameters
ranges = []
input[0].each do |rule_line|
	values = rule_line.split(": ")[1].split(" or ")
	range_1 = values[0].split("-").map{ |num| num.to_i  }
	range_2 = values[1].split("-").map{ |num| num.to_i  }
	ranges << range_1
	ranges << range_2
end

puts ranges.inspect


## parse nearby tickets
invalid_numbers = []
valid_tickets = []
input[2][1..-1].each do |ticket|
	valid_ticket = true
	ticket.split(",").each do |field|
		is_valid = false
		ranges.each do |range|
			if field.to_i.between?(range[0], range[1])
				is_valid = true
				break
			end
		end
		unless is_valid
			invalid_numbers << field.to_i
			valid_ticket = false
		end
	end
	valid_tickets << ticket if valid_ticket
end

puts invalid_numbers.inspect

puts invalid_numbers.sum

# 2353254 is too high
# 20048 is correct
