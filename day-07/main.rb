def part_one(input)
  is_contained_by = []

  input.each do |rule|
    container = rule.split(' bags', 2)[0]
    puts "container: #{container.inspect}"

    constituents = rule.split(' contain ')[1].chomp
        .gsub('.', '')
        .gsub(' bags', '')
        .gsub(' bag', '')
        .split(', ').map {|e| e = e.split(' ', 2)[1]}

    puts "constituents #{constituents}"

    constituents.each do |constituent|
      is_contained_by << [constituent, container]
    end

  end

  puts is_contained_by.inspect

  shiny_gold_containers = is_contained_by.select { |e| e[0] == 'shiny gold' }.map { |e| e[1] }

  puts shiny_gold_containers

  valid_bags = []

  while shiny_gold_containers.size > 0
    active_container = shiny_gold_containers.pop
    valid_bags << active_container
    shiny_gold_containers += is_contained_by.select { |e| e[0] == active_container }.map { |e| e[1] }
    shiny_gold_containers.uniq!
    puts shiny_gold_containers.count
  end

  valid_bags.uniq!

  puts valid_bags.size # 691 is wrong, 348 correct
end

def part_two(input)
  contains = []

  input.each do |rule|
    container = rule.split(' bags', 2)[0]
    puts "container: #{container.inspect}"



    constituents = rule.split(' contain ')[1].chomp
                       .gsub('.', '')
                       .gsub(' bags', '')
                       .gsub(' bag', '')
                       .split(', ')

    puts "constituents #{constituents}"

    constituents.each do |constituent|
      details = constituent.split(' ', 2)
      puts [container, details[1], details[0].to_i].inspect
      contains << [container, details[1], details[0].to_i]
    end
  end

  shiny_gold_bag_contains = contains.select { |e| e[0] == 'shiny gold' }.map { |e| e[1..-1] }

  puts "\n#{shiny_gold_bag_contains}"
  count = 0

  while shiny_gold_bag_contains.size > 0
    active_container = shiny_gold_bag_contains.pop
    puts "active container: #{active_container}"
    count += active_container[1]

    active_container[1].times do
      additional_constituents = contains.select { |e| e[0] == active_container[0] }
      next if additional_constituents == nil
      additional_constituents.each do |additional_constituent|
        additional_constituent = additional_constituent[1..-1]
        shiny_gold_bag_contains << additional_constituent
        puts additional_constituent.inspect
      end
      # exit
    end
  end

  puts count #44 is wrong, 18885 is right (holy smokes!)
end

input = open('input.txt').readlines.reject {|e| e.include? "no other bags"}
#part_one(input)
part_two(input)