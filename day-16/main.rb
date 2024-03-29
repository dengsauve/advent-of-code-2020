require 'pp'

input = open('input.txt').readlines
# parse out three instruction chunks
input = input.chunk{ |item| item == "\n" }
	.reject{ |is_new_line, item_arr| is_new_line }
	.map{ |item_arr| item_arr[1] }

# PART 2
# Get the list of valid tickets
## read in the parameters
ranges = []
range_dict = {}
input[0].each do |rule_line|
	field_name = rule_line.split(": ")[0]
	values = rule_line.split(": ")[1].split(" or ")
	range_1 = values[0].split("-").map{ |num| num.to_i  }
	range_2 = values[1].split("-").map{ |num| num.to_i  }
	range_dict[field_name] = [range_1, range_2]
	ranges << range_1
	ranges << range_2
end

pp range_dict

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

valid_tickets.map!{ |t| t.split(",").map{|tt| tt.to_i} }

## break the valid_tickets into collection of columns
columns = Hash[(0..19).map{|n| [n, []]}]
valid_tickets.each do |ticket|
	ticket.each_with_index do |field, ix|
		columns[ix] << field
	end
end

## run each column against the ranges in the dictionary
range_dict.each do |field, range_arr|
	columns.each do |col_ix, column|
		valid_column = true
		column.each do |value|
			unless value.between?(range_arr[0][0], range_arr[0][1]) or 
			value.between?(range_arr[1][0], range_arr[1][1])
				valid_column = false
			end
		end
		puts "#{col_ix} is a match for #{field}" if valid_column
	end
end
