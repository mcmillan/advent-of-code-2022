struct Item
  def initialize(item : String)
    @item = item.char_at(0)
  end

  def initialize(@item : Char)
  end

  def value
    ascii_code = @item.ord
    ascii_code >= 97 ? ascii_code - 96 : ascii_code - 38
  end
end

struct Rucksack
  def initialize(contents : String)
    middle = (contents.size / 2).to_i

    @first_compartment = Compartment.new(
      contents[0...middle]
    )

    @second_compartment = Compartment.new(
      contents[middle..-1]
    )
  end

  def contents
    @first_compartment.contents + @second_compartment.contents
  end

  def common_item
    Item.new(
      (@first_compartment.contents & @second_compartment.contents).first
    )
  end
end

struct Compartment
  property contents

  def initialize(contents : String)
    @contents = contents.split("")
  end
end

struct ElfGroup
  def initialize(@rucksacks : Array(Rucksack))
  end

  def common_item
    Item.new(
      @rucksacks.map { |r| r.contents }.reduce { |acc, cur| acc & cur }.first
    )
  end
end

puts(
  File.read("input.txt")
    .chomp
    .split("\n")
    .each_slice(3)
    .map do |rucksacks|
      ElfGroup.new(
        rucksacks.map { |r| Rucksack.new(r) }
      ).common_item.value
    end
    .sum
)
