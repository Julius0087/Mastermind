class ComputerCodeMaker

  @code = ''

  def set_code
    @code = generate_code(COLOR_ARRAY).join
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

class ComputerCodeBreaker
  def initialize
    @already_guessed_arr = []
    @guess_arr = Array.new(4) { {locked: false, current_color: nil, color: nil} } # elegantize this - array of hashes
    @filter_color = nil
  end

  def try_guess
    # a hash where colors and positions are locked
    # the guess is then built each round with the hash + filter + trying new colors
    input = pick_a_color
    

    p @guess_arr
    # pick a random color from COLOR_ARRAY - cannot be already tried or filter color
    # input this color
    # based on feedback, do one of the following:
      # if no red feedback, save this color as filter and move to another color (or previously remembered)
      # if no red feedback, but useless color already defined, move to another color
      # if red feedback, and no useless color - remember this color and move to another
      # if red feedback, and useless color defined - lock the color
    
    # set this color to the first available spot and fill the rest with filter
    # if red feedback decreases, try another availible spot
    # if red feedback stays the same - lock this position
    # repeat with another color
  end

  def pick_a_color
    color = COLOR_ARRAY.sample
    @guess_arr.each_with_index do |item, index|
      unless item[:locked]
        item[:current_color] = color
      end
    end
  end
end

class Player

  def guess(string)
    string.upcase.split('')
  end
end

