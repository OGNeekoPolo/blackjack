require_relative "card"

class Deck
  attr_accessor :card_holder

  def initialize
    @card_holder = []
    build_deck
    shuffle_cards
  end

  def build_deck
    Card.suits.each do |suit|
      Card.face.each do |face|
        @card_holder << Card.new(face, suit)
      end
    end
  end

  def shuffle_cards
    @card_holder.shuffle!
  end

  def draw_card
    @card_holder.shift
  end
end
