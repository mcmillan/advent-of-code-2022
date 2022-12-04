struct Elf
  @range : Range(Int32, Int32)

  property range

  def initialize(range : String)
    start, finish = range.split("-").map { |n| n.to_i }
    @range = start..finish
  end

  def covers?(other : Elf)
    (range.to_a & other.range.to_a).any?
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
