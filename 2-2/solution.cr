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

enum Result
  Loss
  Draw
  Win

  def self.from_letter(letter : String) : self
    case letter
    when "X"
      Result::Loss
    when "Y"
      Result::Draw
    else
      Result::Win
    end
  end
end

enum Shape
  Rock
  Paper
  Scissors

  def self.from_letter(letter : (String | Shape))
    letter.is_a?(Shape) ? letter : CONVERSION[letter]
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

  def shape_to_produce(result : Result)
    case result
    when Result::Draw
      self
    when Result::Loss
      WINNING_SHAPES[self]
    else
      LOSING_SHAPES[self]
    end
  end
end

puts(
  File.read("input.txt")
    .chomp
    .split("\n")
    .map do |round|
      opponent_shape_letter, result_letter = round.split(" ")

      opponent_shape = Shape.from_letter(opponent_shape_letter)
      desired_result = Result.from_letter(result_letter)
      my_shape = opponent_shape.shape_to_produce(desired_result)

      my_shape.score + my_shape.score_from_battle_against(opponent_shape)
    end
    .sum
)
