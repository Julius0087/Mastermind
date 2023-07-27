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

# TODO:
# testing and upload

# DONE:
# optimizating algorithm - computer now skips the last logical position and locks it and moves to another color
# fixed player codebreaking termination when won
# added a sleep method to slow down computer breaking output
# added round numbering and changed guessed code to string instead of an array
