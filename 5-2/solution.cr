rows, instructions = File.read("input.txt")
  .chomp
  .split("\n\n")
  .map { |s| s.split("\n") }

stacks = rows.pop.strip.split(/\s+/).map { [] of Char }

rows.each do |row|
  row.chars.each_slice(4).map do |slice|
    slice[1]
  end.each_with_index do |item, index|
    stacks[index] << item unless item.whitespace?
  end
end

instructions.each do |instruction|
  match = /move (\d+) from (\d+) to (\d+)/.match(instruction)

  raise "can't parse `#{instruction}`" if match.nil?

  count, from, to = match.captures.map { |num| num.to_s.to_i }

  from_index = from - 1
  to_index = to - 1

  items = stacks[from_index].shift(count)
  stacks[to_index] = items + stacks[to_index]
end

puts stacks.map { |s| s.first }.join
