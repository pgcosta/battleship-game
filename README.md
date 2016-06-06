# battleship-game

# To run the game
`ruby game.rb`

Note: Didn't took the time to validate the inputs. Not tested against keyboard smashing!

Default size for grid is 6x6.

# Run the tests
`rspec spec/`

# Overview
## Player
Class to represent a player.

Has a name, health and a board.

The health is the health sum of the healh of each boat on the board.

## Board
Class to represent a board.

Has a grid, and boats.

Default size of grid is 6x6.

Handles all the operations related with a board, namely placing boats and handling attacks on the board.

## Boat
Class to represent a boat.

Has size, health, orientation, row, column.

Row, column and orientation represent the position of a boat.

Boats are placed left to right if horizontal, and top to bottom if vertical.

## Game
A module.

It has a main_loop that handles an entire match.
