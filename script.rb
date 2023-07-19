require "./classes.rb"
require "./modules.rb"

COLOR_ARRAY = ["R", "G", "B", "Y", "W", "P"]

loop do
  puts 'Type 1 to be the codemaker, type 2 to be the codebreaker'
  choice = gets.chomp.to_i
  break if choice == 1 || choice == 2
end

# game.player_breaks
# game.player_makes
player = Player.new
computer = ComputerCodeMaker.new
code_array = computer.set_code.split('')

# testing
computer_codebreaker = ComputerCodeBreaker.new
computer_codebreaker.try_guess

for i in 1..12
  puts "Round #{i}. Guess the colors."
  guess = check_input

  guess_array = player.guess(guess)
  result = give_feedback(guess)
  if result[0] == true
    puts 'The code was:'
    puts code_array.join()
    exit
  end
end
puts 'You lose! The code was:'
puts code_array.join()


# TODO:
# player class refactor
# new give feedback method for the computer codebreaker
# module for methods that both computers share

# DONE:
# algorithm start
# new class distinction - computer codebreaker/codemaker
# new file to sort classes and main
# new file modules to store the feedback method and input check
# main game refactor
