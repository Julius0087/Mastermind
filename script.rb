COLOR_ARRAY = ["R", "G", "B", "Y", "W", "P"]

class Computer

  @code = ''

  def set_code
    @code = generate_code(COLOR_ARRAY).join
  end

  def give_feedback(guess)
    guess = guess.split('')
    code_array = @code.split('')
    red_feedback = 0
    red_feedback_array = []
    guess.each_with_index do |color, index|
      if code_array[index] == color
        red_feedback += 1
        red_feedback_array.push(color)
      end
    end

    if red_feedback == 4
      puts 'Correct combination guessed, you win!'
      return true
    end

    white_feedback = 0
    white_feedback_array = []
    remaining_array = guess.difference(red_feedback_array)
    remaining_array.each do |color|
      # make sure it's not counting the same color twice
      if code_array.include?(color) && white_feedback_array.none? { |n| n == color }
        white_feedback += 1
        white_feedback_array.push(color)
      end
    end
    puts "You guessed #{red_feedback} colors at the correct position and #{white_feedback} correct colors at the wrong position."
    false
  end

  private

  attr_accessor :code

  def generate_code(color_array)
    code_array = []
    while code_array.length < 4 do
      new_color = color_array.sample
      unless code_array.include?(new_color)
        code_array.push(new_color)
      end
    end
    code_array
  end

end

class Player

  def guess(string)
    string.upcase.split('')
  end
end

def check_validity(array)
  array.each do |item|
    unless COLOR_ARRAY.include?(item)
      return false
    end
    true
  end
end

player = Player.new
computer = Computer.new
code_array = computer.set_code.split('')

for i in 1..12
  puts "Round #{i}. Guess the colors."
  guess = ''
  loop do
    guess = gets.chomp.upcase
    if guess.match?(/[A-Z]/) && guess.length == 4 && check_validity(guess.split(''))
      break
    else
      puts 'Invalid guess. Select only four of color letters (R, G, B, Y, W, P)'
    end
  end

  guess_array = player.guess(guess)
  break if computer.give_feedback(guess)

end
puts 'The code was:'
puts code_array.join()

# TODO:
# add termination when the code is guessed correctly
# fix white feedback on guessing same color more times in one turn
