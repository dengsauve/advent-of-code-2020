require '../lib/aoc-lib.rb'
input = open('./input.txt').readlines

class Bag

  attr_accessor :name, :can_contain, :contained_by

  def initialize(name)
    @name = name
    @can_contain = {}
    @contained_by = []
  end

  def to_s
    "#{@name}, can contain: #{@can_contain}, contained by: #{@contained_by}"
  end

end

bags = []

input.each do |rule|
  container = rule.split('contain')[0].split(' bags')[0]
  # check here for existing bag
  bag = Bag.new(container)
  bags << bag

  containees = rule.split('contain')[1][0..-2].split('bags').map{|e| e.strip!}.join.split(", ")

  containees.each do |containee|
    bag.can_contain[containee[1]] = containee[0].to_i
    # check if the bag has been created
    if bags.select {|b| b.name == containees[1]}.size == 0
      bagee = Bag.new(containees[1])
    else
      bagee = bags.select {|b| b.name == containees[1]}.first
    end
    bagee.contained_by << bag.name
  end

end

puts bags