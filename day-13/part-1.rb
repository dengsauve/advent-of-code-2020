input = open('input.txt').readlines(:chomp => true)

available_at = input[0].to_i
times = input[1].split(',').reject { |e| e == 'x' }.map { |e| e.to_i }

puts available_at, times.inspect

wait_time = available_at
chosen_time = available_at

times.each do |time|
  wait = time - (available_at % time)
  if wait < wait_time
    wait_time = wait
    chosen_time = time
  end
end

puts wait_time, chosen_time, wait_time * chosen_time