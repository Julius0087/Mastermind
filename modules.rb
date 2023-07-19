module Feedback
  def give_feedback(guess, code)
    guess = guess.split('')
    code_array = code.split('')

    red_feedback = 0
    red_feedback_array = []
    guess.each_with_index do |color, index|
      if code_array[index] == color
        red_feedback += 1
        red_feedback_array.push(color)
      end
    end

    if red_feedback == 4
      puts 'Correct combination guessed, codebreaker wins!'
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
    puts "Codebreaker guessed #{red_feedback} colors at the correct position and #{white_feedback} colors at the wrong position."
    [red_feedback, white_feedback]
  end
end

module Validity
  def check_validity(array)
    array.each do |item|
      unless COLOR_ARRAY.include?(item)
        return false
      end
      true
    end
  end

  def check_input
    loop do
      guess = gets.chomp.upcase
      if guess.match?(/[A-Z]/) && guess.length == 4 && check_validity(guess.split(''))
        break
      else
        puts 'Invalid guess. Select only four of color letters (R, G, B, Y, W, P)'
      end
    end
    guess
  end
end

