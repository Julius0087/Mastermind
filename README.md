# Mastermind
A ruby script for The Odin Project. Based on a code-breaking board game Mastermind.

A mastermind game played in the terminal with two game modes. You can choose to be the codebreaker - in this case the computer generates a four letter code that you have to guess in 12 turns.
With each guess you recieve a feedback on how many colors you guessed correctly and whether on correct positions or not.
Based on this, you keep guessing the combination until the correct code is guessed or you run out of turns.

You can also choose to be the codemaker, in which case the computer will try and break the code. The algorithm tries a single letter on all positions to find if it's found in the code.
Then it tries all the possible positions and locks it in place when position is found. This process is then repeated to find all the letters and their positions.

## Rules
The codebreaker has 12 turns to find the correct combination. There are 6 colors (letters) that the code can be made from. Repetitions are not allowed, however it is allowed to guess one color on multiple positions.
Blanks are also not allowed. Player tries to break the code by typing their guess in the terminal - lowcase or upcase.
