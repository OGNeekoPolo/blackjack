Scheme of the Game

New Game
- prompt the user if they want to play
    - Would you like to play a game?
    - Receive input from user using the method 'gets'

Initial Deal
- deal the initial hands
    - Create a deck
    - Shuffle Deck
    - 2.times do (deals out 2 cards in this method)
    - Show 2 cards for the player and only the first card for the dealer

Hit/Stay
- Hit/Stay phase (User's turn)
    - Given the value of their hand, prompt the user to hit or stay
    - Receive user input using the method 'gets'
        - Upon hit, player is dealt another card from the deck
          - If player hits, and they have not gone over 21, they can hit again
        - If player stays, then move on to the next phase

Dealers Turn
- Dealer's turn
    - If dealer_value == 21, then the game is automatically over
    - If dealer_value < 17, the dealer MUST hit
    - Else, the dealer has to stay

Output
- Displays outcome of the game
    - Puts "Player Score"
    - Puts "Dealer Score"
    - Puts "You Win/Lose"

- Game Over Prompt
  - Uses the 'get' method to get input from the user in order to start a new game
