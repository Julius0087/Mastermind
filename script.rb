color_array = ["R", "G", "B", "Y", "W", "P"]

class Computer

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

  def give_feedback(guess, code_array)
    red_feedback = 0
    red_feedback_array = []
    guess.each_with_index do |color, index|
      if code_array[index] == color
        red_feedback += 1 
        red_feedback_array.push(color)
      end
    end

    white_feedback = 0
    remaining_array = guess.difference(red_feedback_array)
    remaining_array.each do |color| 
      white_feedback += 1 if code_array.include?(color)
    end
    "You guessed #{red_feedback} colors at the correct position and #{white_feedback} correct colors at the wrong position."
  end

end

computer = Computer.new
code_array = computer.generate_code(color_array)
p code_array
guess = ["R", "Y", "B", "G"]
puts computer.give_feedback(guess, code_array)

# TODO:
# make sure code isn't accessible, only inside the computer class (try making it a class variable @@)
# add proper 12 turns and prompts, conversion to arrays
