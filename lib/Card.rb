class Card
  # include Comparable for <=> operator-based comparisons
  include Comparable

  public
  attr_reader :suit, :value
  
  ACE       = 1
  JACK      = 11
  QUEEN     = 12
  KING      = 13

  VALUES    = ACE..KING

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
    @value >= JACK
  end

  def ace?
    @value == ACE
  end

  def <=> other
    raise ArgumentError, "Cannot perform comparison with #{other.class}" unless other.is_a? Card

    result = self.value <=> other.value
    return result unless result.zero?
    return self.suit <=> other.suit
  end

  # string methods
  def to_s
    value = @value
    case
      when @value == ACE   then value = 'A'
      when @value == JACK  then value = 'J'
      when @value == QUEEN then value = 'Q'
      when @value == KING  then value = 'K'
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
