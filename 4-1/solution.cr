struct Elf
  @range : Range(Int32, Int32)

  property range

  def initialize(range : String)
    start, finish = range.split("-").map { |n| n.to_i }
    @range = start..finish
  end

  def covers?(other : Elf)
    range.begin >= other.range.begin && range.end <= other.range.end ||
      other.range.begin >= range.begin && other.range.end <= range.end
  end
end

puts(
  File.read("input.txt")
    .chomp
    .split("\n")
    .select do |pairing|
      first_elf, second_elf = pairing.split(",").map { |range| Elf.new(range) }
      first_elf.covers?(second_elf)
    end
    .size
)
