class Card
  attr_accessor :suit, :face, :value

  def initialize(face, suit)
    @face = face
    @suit = suit
    @value = 0
    set_value
  end

  def self.face
    %w(Ace 2 3 4 5 6 7 8 9 10 Jack Queen King)
  end

  def self.suits
    %w(Hearts Clubs Diamonds Spades)
  end

  def set_value
    if %w(Jack Queen King).include? @face
      @value = 10
    elsif face == "Ace"
      @value = 11
    else
      @value = @face.to_i
    end
  end

  def +(other_cards)
    value + other_cards.value
  end

  def to_s
    "#{@face} of #{@suit}"
  end
end
