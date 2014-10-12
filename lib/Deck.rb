require_relative 'Suit'
require_relative 'Card'
require_relative 'CardHolder'

class Deck
  include CardHolder

  private
  @decks
  @place

  public
  def initialize decks = 1
    raise ArgumentError, "Invalid number of decks #{decks.inspect}" unless decks.is_a? Integer and decks.positive?

    @decks = decks
    @cards = []
    @decks.times do
      Suit::SUITS.each do |suit|
        Card::VALUES.each do |value|
          @cards << Card.new(suit, value)
        end
      end
    end

    @place = 0
    shuffle!
  end
  
  def clone
    deck = Deck.new @decks
    
    deck.cards = @cards
    deck.place = @place
    
    deck.shuffle!
    deck
  end

  protected
  def place= place
    raise ArgumentError, 'Place must be an integer' unless place.is_a? Integer
    raise ArgumentError, 'Place is out of bounds' unless place >= 0 and place < @cards.count

    @place = place
  end
  
  def dealt
    dealt = []
    if @place.positive?
      dealt = @cards[0...@place]
    end
    dealt
  end

  public
  def cards
    @cards[@place..@cards.count]
  end

  def shuffle!
    @cards = dealt + cards.shuffle
    self
  end

  def draw_card
    card = @cards[@place]
    @place += 1

    if @place >= @cards.count
      @place = 0
      shuffle!
    end
    
    card
  end

  def draw cards = 1
    raise ArgumentError, "Number of cards must be an Integer #{cards.inspect}" unless cards.is_a? Integer
    raise ArgumentError, 'Number of cards must be positive' unless cards.positive?

    drawn = []
    cards.times do
      drawn << draw_card
    end
    drawn
  end
  
  def reset
    @place = 0
    shuffle!
  end
end
