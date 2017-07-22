require_relative 'deck'
# require "pry"
class Game

  attr_accessor :player_hand, :dealer_hand, :deck, :player_value, :dealer_value, :win_tracker, :loss_tracker, :bank

  def initialize
    @win_tracker = 0
    @loss_tracker = 0
    @bank = 100
    puts "Welcome to BlackJack!! Lets get started....[Enter to continue]"
    gets
  end

  def play_game
    puts "Ready to play? [Press Enter to continue]"
    gets
    @bank -= 10
    puts "$10 Bet Placed"
    puts "Remaining Money: #{@bank}"
    set_deck
    deal_cards
    player_phase
    dealer_phase
    new_game?
  end


  def set_deck
    @player_hand = []
    @dealer_hand = []
    @player_value = 0
    @dealer_value = 0
    @deck = Deck.new
  end

  def deal_cards
    puts "Dealing out the cards...[Press enter to continue]"
    gets
    2.times do
      @player_hand << @deck.draw_card
      @dealer_hand << @deck.draw_card
    end
  end


  def total_dealer_value
  end

  def player_phase
    @player_value = @player_hand.reduce(0) {|sum, value| sum + value.value}
    @dealer_value = @dealer_hand.reduce(0) {|sum, value| sum + value.value}
    if @player_value == 21
      puts "Player has BlackJack!! You Win!!!"
      @win_tracker += 1
      @bank += 20
      new_game?
    else
      puts "Your hand has a value of #{@player_value}."
      puts "It is made up of a #{@player_hand[0]} and a #{@player_hand[1]}."
      puts "The dealer is showing that their first card is a #{@dealer_hand[0]}."
      puts "Would you like a hit? (y / n)"
      hit = gets.chomp.downcase
      if hit == "y"
        hit(@player_hand)
      else
        dealer_phase
      end
    end
  end

  def dealer_phase
    puts "The dealer flips his second card...[Hit enter to proceed]"
    gets
    puts "The dealer has a hand value of #{@dealer_value}"
    puts "It is made up of a #{@dealer_hand[0]} and a #{@dealer_hand[1]}."
    if @dealer_value < 17
      puts "The dealer is about to hit....[Press Enter to proceed]"
      gets
      hit(dealer_hand)
      @dealer_value = @dealer_hand.reduce(0) {|sum, value| sum + value.value}
      if @dealer_value < 17
        hit(dealer_hand)
      elsif @dealer_value > 21
        puts "Dealer busted with #{@dealer_value}. YOU WIN!!!"
        @win_tracker += 1
        @bank += 20
        new_game?
      elsif @dealer_value > 17 && @dealer_value < @player_value
        puts "Your hand of #{@player_value} beats the dealers hand of #{@dealer_value}"
        puts "YOU WIN!!!"
        @win_tracker += 1
        @bank += 20
        new_game?
      elsif @dealer_value > @player_value
        puts "The dealer has a hand of #{@dealer_value} which beats your hand of #{@player_value}"
        puts "YOU LOSE"
        @loss_tracker += 1
        new_game?
      elsif @dealer_value == @player_value
        puts "You and the dealer have the same value of #{@player_value}"
        puts "That was close....but YOU WIN!!!"
        @win_tracker += 1
        @bank += 20
        new_game?
      end
    elsif @dealer_value == 21 && @dealer_value > @player_value
      puts "Dealer has blackjack. YOU LOSE!!"
      @loss_tracker += 1
      new_game?
    elsif @dealer_value > 17 && @dealer_value < @player_value
      puts "Your hand of #{@player_value} is better than the dealers hand of #{@dealer_value}"
      puts "You WIN!!!"
      @win_tracker += 1
      @bank += 20
      new_game?
    elsif @dealer_value > 17 && @dealer_value == @player_value
      puts "You and the dealer have the same value of #{@player_value}"
      puts "That was close....but YOU WIN!!!"
      @win_tracker += 1
      @bank += 20
      new_game?
    elsif @dealer_value > 17 && @dealer_value > @player_value
      puts "The dealers hand of #{@dealer_value} is better than your hand of #{@player_value}"
      puts "YOU LOSE!!"
      @loss_tracker += 1
      new_game?
    end
  end

  def hit(active_hand)
    if active_hand == @player_hand
      @player_hand << @deck.draw_card
      @player_value = @player_hand.reduce(0) {|sum, value| sum + value.value}
      if @player_value <= 21
        puts "You ended up drawing a #{@player_hand[2]}"
        puts "Your hand has a new value of #{@player_value}."
        puts "Would you like another hit?"
        hit = gets.chomp.downcase
        if hit == "y"
          hit(active_hand)
        else
          dealer_phase
        end
      else
        puts "Your busted with a hand value of #{@player_value}. You Lose!"
        @loss_tracker += 1
        new_game?
      end
    else
      @dealer_hand << @deck.draw_card
    end
  end

  def new_game?
    puts "Money: #{@bank}"
    puts "Losses: #{@loss_tracker}"
    puts "Wins: #{@win_tracker}"
    if @bank == 0
      puts "Your bank is empty. Time to go home"
      puts "Goodbye!"
      exit
    else
      puts "Would you like to play again? Press (y / n)"
      rematch = gets.chomp.downcase
      if rematch == "y"
        play_game
      else
        puts "Thanks for playing...Goodbye!"
        exit
      end
    end
  end
end

# binding.pry
Game.new.play_game
