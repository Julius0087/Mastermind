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
    @color = nil
    @already_guessed_arr = []
    @to_try_arr = []
    @indexes_to_guess = [0, 1, 2, 3]
    @guess_arr = Array.new(4) { {locked: false, current_color: nil, color: nil} }
    @filter_color = nil
    @last_round_red = 0
    @awaiting_position_feedback = false
    @last_locked_index = nil
    @target_feedback = nil
  end

  def play_game(code)
    12.times do
      self.try_guess(code)
    end
  end

  def try_guess(code)
    unless @awaiting_position_feedback
      if @to_try_arr.empty? || @filter_color.nil?
        @color = pick_a_color
        self.try_color(@color)
      else
        @color = @to_try_arr[0]
        @to_try_arr.delete_at(0)
        puts 'trying color'
        self.try_position(@color)
      end
    end

    # build the guess code from the hash array
    new_guess = []
    @guess_arr.each do |hash|
      new_guess.push(hash[:current_color])
    end

    p new_guess
    feedback = give_feedback(new_guess.join, code.split(''))
    exit if feedback == 'win'
    red = feedback[0]

    @target_feedback = self.select_target_feedback

    # feedback handling
    if @filter_color.nil?
      if red == 0
        @filter_color = @color
      elsif red == 1
        @to_try_arr.push(@color)
      end
    elsif red == @target_feedback - 1 && @awaiting_position_feedback == false
      @already_guessed_arr.push(@color)
    elsif red == @target_feedback && @awaiting_position_feedback == true
      self.lock_position(@color)
    else
      self.try_position(@color)
    end

    @last_round_red = red

    # pick a random color from COLOR_ARRAY - cannot be already tried or filter color or to_try
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
    # pick a random color - not already guessed, not filter, not those that are to be tried later
    available = COLOR_ARRAY.difference(@already_guessed_arr, @to_try_arr, [@filter_color])
    return available.sample
  end

  def try_color(color)
    # fill all unlocked spots with this color
    @guess_arr.each do |item|
      unless item[:locked]
        item[:current_color] = color
      end
    end
  end

  def try_position(color)
    # pick an index to guess
    index = @indexes_to_guess[0]
    puts index

    @guess_arr[index][:current_color] = color
    @guess_arr[index][:locked] = true
    
    # unlock the previously locked
    unless @last_locked_index.nil?
      @guess_arr[@last_locked_index][:locked] = false
    end
    @last_locked_index = index
    @indexes_to_guess.delete_at(0)

    # fill the rest with filter
    @guess_arr.each do |hash|
      unless hash[:locked]
        hash[:current_color] = @filter_color
      end
    end
    @awaiting_position_feedback = true
  end

  def lock_position(color)
    @guess_arr.each do |hash|
      if hash[:current_color] == color
        hash[:color] = color
      end
    end
    @awaiting_position_feedback = false
    @last_locked_index = nil
    @already_guessed_arr.push(color)
    @indexes_to_guess = []
    @guess_arr.each_with_index do |hash, index|
      if hash[:locked] == false
        @indexes_to_guess.push(index)
      end
    end
    puts 'position locked'
  end

  def select_target_feedback
    feedback = 0
    @guess_arr.each do |hash|
      unless hash[:color].nil?
        feedback += 1
      end
    end
    feedback + 1
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

