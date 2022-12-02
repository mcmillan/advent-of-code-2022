CONVERSION = {
  "A" => Shape::Rock,
  "B" => Shape::Paper,
  "C" => Shape::Scissors,
  "X" => Shape::Rock,
  "Y" => Shape::Paper,
  "Z" => Shape::Scissors,
}

SCORES = {
  Shape::Rock     => 1,
  Shape::Paper    => 2,
  Shape::Scissors => 3,
}

LOSING_SHAPES = {
  Shape::Rock     => Shape::Paper,
  Shape::Paper    => Shape::Scissors,
  Shape::Scissors => Shape::Rock,
}

WINNING_SHAPES = LOSING_SHAPES.invert

enum Shape
  Rock
  Paper
  Scissors

  def self.from_letter(letter : String)
    CONVERSION[letter]
  end

  def score
    SCORES[self]
  end

  def score_from_battle_against(other : Shape)
    if self == other
      3
    elsif other == LOSING_SHAPES[self]
      0
    else
      6
    end
  end
end

puts(
  File.read("input.txt")
    .chomp
    .split("\n")
    .map do |round|
      opponent, mine = round.split(" ")

      opponent_shape = Shape.from_letter(opponent)
      my_shape = Shape.from_letter(mine)

      my_shape.score + my_shape.score_from_battle_against(opponent_shape)
    end
    .sum
)
