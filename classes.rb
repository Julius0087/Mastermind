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
    @to_try_arr = []
    @guess_arr = Array.new(4) { {locked: false, current_color: nil, color: nil} }
    @filter_color = nil
    @last_round_red = nil
  end

  def play_game(code)
    # 12.times do
      self.try_guess(code)
    # end
  end

  def try_guess(code)
    # a hash where colors and positions are locked
    # the guess is then built each round with the hash + filter + trying new colors
    color = pick_a_color

    new_guess = []
    @guess_arr.each do |hash|
      new_guess.push(hash[:current_color])
    end

    feedback = give_feedback(new_guess.join, code.split(''))
    red = feedback[0]

    if red == 0 || red == @last_round_red
      if @filter_color == nil # elegantize?
        @filter_color = color
      end
    else
      if @filter_color == nil
        @to_try_arr.push color
      else
        # find the first unlocked spot, lock it with the current color
        index = @guess_arr.find_index { |hash| hash[:locked] == false }
        @guess_arr[index][:locked] = true
        @guess_arr[index][:current_color] = color
      end
    end


    
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
    # populate an array with the chosen color
    color = COLOR_ARRAY.sample
    @guess_arr.each do |item|
      unless item[:locked]
        item[:current_color] = color
      end
    end
    color
  end
end

class Player

  def guess(string)
    string.upcase.split('')
  end

  def input_code
    puts 'Enter your secret code:'
    loop do
      input = gets.chomp.upcase
      return input if check_input(input) && check_duplicates(input)
    end
  end

  def player_breaks(code_array)
    for i in 1..12
      puts "Round #{i}. Guess the colors."
      input = ''
      loop do
        input = gets.chomp.upcase
        break if check_input(input)
      end
  
      guess_array = self.guess(input)
      result = give_feedback(input, code_array)
      if result == true
        puts 'The code was:'
        puts code_array.join()
        exit
      end
    end
    puts 'You lose! The code was:'
    puts code_array.join()
  end
end

