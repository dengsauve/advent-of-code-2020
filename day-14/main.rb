require 'pp'

input = open('input.txt').readlines

bit_mask = ''
memory = {}


# Methods

## Convert Decimal into 36 bit integer
def decimal_to_36_bit_string(number)
	bit_string = number.to_s(2)
	return bit_string.rjust(36, "0")
end


## Convert 36 bit integer into decimal
def bit_string_to_decimal(bit_string)
	return bit_string.to_i(2)
end


## Apply bit_mask to 36 bit integer
def mask_bit_string(bit_string, mask)
	(0..35).each do |index|
		if mask[index] == '0'
			bit_string[index] = '0'
		elsif mask[index] == '1'
			bit_string[index] = '1'
		end
	end
	return bit_string
end


# Actions!!
## Read each input line
input.each do |command|
	case command[0..2]
	when 'mas'
		bit_mask = command.split()[2]
	when 'mem'
		# mem[43805] = 6934
		# grab the integer for memory location
		i = command[/\[.*?\]/][1..-2].to_i
		# grab the integer for memory insertion
		value = command.split()[2].to_i
		bit_value = decimal_to_36_bit_string(value)
		# Apply the bit mask
		masked_bit_value = mask_bit_string(bit_value, bit_mask)
		# Write bit string to memory
		memory[i] = masked_bit_value
	end
	
	if false
		system('clear')
		pp bit_mask, memory
		gets
	end
end

## Total up all values in memory

values = memory.values
total = 0
values.each do |value|
	total += bit_string_to_decimal(value)
end
puts total

## Part 1 answer: 10035335144067

# PART 2

bit_mask = ''
memory = {}

## Apply bit_mask to 36 bit integer
def float_mask_bit_string(bit_string, mask)
	# Get the number of combinations
	number_of_floats = mask.count('X')
	
	puts "Parsing floats, found #{number_of_floats} floats to compute\n\
Expect #{2 ** number_of_floats} combinations to try"
	
	ingredients = [0,1] * number_of_floats
	combinations = ingredients.combination(number_of_floats).to_a.uniq
	values = []
	
	if combinations.count != 2 ** number_of_floats
		raise "Error: #{combinations.count} != #{2 ** number_of_floats}"
	end
	
	combinations.each do |f| # f is for float ;) array
		bit_string_copy = "#{bit_string}"
		(0..35).each do |index|
			if mask[index] == '0'
				# No Change 
			elsif mask[index] == '1'
				bit_string_copy[index] = '1'
			elsif mask[index] = 'X'
				bit_string_copy[index] = "#{f.pop}"
			end
		end
		values << bit_string_copy
	end
	
	raise("duplicates found") if values.uniq.count != combinations.count
	
	return values
end

# actions
input.each_with_index do |command, index|
	puts "\nexecuting command #{index}: #{command}"
	case command[0..2]
	when 'mas'
		bit_mask = command.split()[2]
	when 'mem'
		# mem[43805] = 6934
		# grab the integer for memory location
		i = command[/\[.*?\]/][1..-2].to_i
		# write that as a bit_string
		i_bit_string = decimal_to_36_bit_string(i)
		# grab the integer for memory insertion
		value = command.split()[2].to_i
		# Apply the bit mask (returns array)
		masked_addresses = float_mask_bit_string(i_bit_string, bit_mask)
		# Write bit string to memory
		masked_addresses.each do |address|
			i = bit_string_to_decimal(address)
			memory[i] = value
		end
	end
end

puts "\ncalculating grand total"

values = memory.values.flatten
total = 0
values.each do |value|
	total += value
end

puts total, total == 3817372618036

# 3817372618036 is correct :D
# 2067229924246400 is too high :/
# 2577478930633984 is too high :/
# 2578157945489184