require './classes.rb'
require './modules.rb'

include Feedback
include Validity

COLOR_ARRAY = ["R", "G", "B", "Y", "W", "P"]
choice = 0


loop do
  puts 'Type 1 to be the codemaker, type 2 to be the codebreaker'
  choice = gets.chomp.to_i
  break if choice == 1 || choice == 2
end

player = Player.new

if choice == 2
  computer = ComputerCodeMaker.new
  code_array = computer.set_code.split('')
  player.player_breaks(code_array) # should also be split into game and rounds
else
  computer = ComputerCodeBreaker.new
  code = player.input_code
  computer.play_game(code)
end
# game.player_breaks
# game.player_makes


# testing
# computer_codebreaker = ComputerCodeBreaker.new
# computer_codebreaker.try_guess



# TODO:
# if only one position remaining - don't bother trying, set automatically

# DONE:
# method refactor in computer codebreaker class
# working algorithm - can now guess the code with enough turns
