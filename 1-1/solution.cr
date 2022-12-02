puts File.read("input.txt")
  .chomp
  .split("\n\n")
  .map { |elf| elf.split("\n").map { |count| count.to_i }.sum }
  .max
