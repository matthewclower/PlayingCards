class Card
  attr_accessor :suit, :value
  
  private
  MIN_VALUE = 1  # Ace/1
  MAX_VALUE = 13 # King

  public
  VALUES    = MIN_VALUE..MAX_VALUE

  private
  @suit     = nil
  @value    = nil

  public
  def initialize suit, value
    raise ArgumentError, "Invalid Suit #{suit}" unless Suit.valid? suit
    raise ArgumentError, "Invalid Value #{value}" unless VALUES.include? value

    @suit, @value = suit, value
  end
  
  def face_card?
    @value >= 11
  end

  def ace?
    @value == 1
  end

  # string methods
  def to_s
    value = @value
    case
      when @value == 1  then value = 'A'
      when @value == 11 then value = 'J'
      when @value == 12 then value = 'Q'
      when @value == 13 then value = 'K'
    end
    case @suit
      when Suit::SPADES   then suit = Suit::SPADE
      when Suit::HEARTS   then suit = Suit::HEART
      when Suit::DIAMONDS then suit = Suit::DIAMOND
      when Suit::CLUBS    then suit = Suit::CLUB
    end
    "#{value}#{suit}"
  end

  def to_str
    to_s
  end
end
