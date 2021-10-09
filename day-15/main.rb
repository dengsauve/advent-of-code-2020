input = [5,2,8,16,18,0,1]
indexes = {}
target = 2020

input[0...-1].each_with_index do |t, i|
	indexes[t] = i
end

=begin
# Find the most recent (starting from end) occurrence of target in array
# Return 0 if none
def find_last_instance(target, arr)
	last_occurence_ix_arr = arr.each_index.select{|i| arr[i] == target}
	
	return 0 if last_occurence_ix_arr.count == 0
	
	return arr.count - last_occurence_ix_arr.max
end
=end

until input.length == target do
	# puts "input", input.inspect, "indexes", indexes.inspect
	# gets
	
	last_num = input[-1]
	next_num = 0
	if indexes.has_key?(last_num)
		# puts "found key"
		next_num = input.length - (indexes[last_num] + 1)
	end
	indexes[last_num] = input.length - 1
	input << next_num
end

puts "The #{target}th number is: #{input[-1]}"