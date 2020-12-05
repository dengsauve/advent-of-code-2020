input = open('./input.txt').read
required_fields = %w[byr iyr eyr hgt hcl ecl pid]
valid_count = 0
validated_count = 0

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def get_hash(group)
  h = {}
  group.gsub("\n", ' ').split(' ').each do | pair |
    key = pair.split(':')[0]
    value = pair.split(':')[1]
    h[key] = value
  end
  h
end

def validated(h)
  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  return false unless (h['byr'].to_i.between?(1920, 2002) and h['byr'].length == 4) and
    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    (h['iyr'].to_i.between?(2010, 2020) and h['iyr'].length == 4) and
    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    (h['eyr'].to_i.between?(2020, 2030) and h['eyr'].length == 4) and
    # hgt (Height) - a number followed by either cm or in:
    (h['hgt'][0].numeric? and (h['hgt'].split('').last(2).join == 'in' or h['hgt'].split('').last(2).join == 'cm')) and
    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    (h["hcl"][0] == "#" and h["hcl"].length == 7 and h["hcl"][1..6][/([a-f0-9]+)/] == h["hcl"][1..6]) and
    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    %w[amb blu brn gry grn hzl oth].include?(h['ecl']) and
    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    (h["pid"].length == 9 and h["pid"].numeric?)
  # If cm, the number must be at least 150 and at most 193.
  if h['hgt'].split('').last(2).join == 'cm'
    return false unless h['hgt'][0..2].to_i.between?(150,193)
  end
  # If in, the number must be at least 59 and at most 76.
  if h['hgt'].split('').last(2).join == 'in'
    return false unless h['hgt'][0..1].to_i.between?(59,76)
  end
  # cid (Country ID) - ignored, missing or not.

  true
end

input.split("\n\n").each do | group |
  h = get_hash(group)
  valid = true

  required_fields.each do |field|
    valid = false unless h.key?(field)
  end

  valid_count += 1 if valid #208 <- part one
  if valid
    validated_count += 1 if validated(h)#167 <- part two
  end
end

puts "Valid ID count: #{valid_count}", "Validated ID count: #{validated_count}"