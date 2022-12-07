UNIQUE_CHAR_COUNT = 4

input = File.read("input.txt").chomp

(input.size).times do |n|
  range = input[(n...(n + UNIQUE_CHAR_COUNT))]

  if range.chars.uniq.size == UNIQUE_CHAR_COUNT
    puts n + UNIQUE_CHAR_COUNT
    break
  end
end
