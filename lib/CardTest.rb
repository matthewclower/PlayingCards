require_relative 'Card'

class CardTest < RubyUnit::TestCase
  def constantTest konstant, value
    assertConst value, Card, konstant, "Card constant #{konstant} is not the right value!"
  end

  def createValidCardTest suit, value
    card = Card.new suit, value
    assertInstanceOf Card, card, 'Card must be instance of Card'
  end
  
  def createInvalidCardTest suit, value, message
    assertRaiseExpected ArgumentError, message, 'Should not be able to create Card with invalid suit or value' do
      card = Card.new suit, value
    end
  end

  def faceCardTest card
    assert card.face_card?, "#{card} should be a face card"
  end

  def notFaceCardTest card
    assertNot card.face_card?, "#{card} should not be a face card"
  end

  def aceTest card
    assert card.ace?, "#{card} should be an ace"
  end

  def notAceTest card
    assertNot card.ace?, "#{card} should not be an ace"
  end

  def spaceshipTest card1, card2, expected
    assertEqual expected, (card1 <=> card2), 'Spaceship comparison failed!'
  end

  def lessThanTest card1, card2
    assert (card1 < card2), 'Less than comparison incorrect!'
  end

  def notLessThanTest card1, card2
    assertNot (card1 < card2), 'Less than comparison incorrect!'
  end

  def lessThanOrEqualToTest card1, card2
    assert (card1 <= card2), 'Less than comparison incorrect!'
  end

  def notLessThanOrEqualToTest card1, card2
    assertNot (card1 <= card2), 'Less than comparison incorrect!'
  end

  def equalTest card1, card2
    assert (card1 == card2), 'Equality comparison incorrect!'
  end

  def notEqualTest card1, card2
    assertNot (card1 != card2), 'Equality comparison incorrect!'
  end

  def greaterThanTest card1, card2
    assert (card1 > card2), 'Greater than comparison incorrect!'
  end

  def notGreaterThanTest card1, card2
    assertNot (card1 > card2), 'Greater than comparison incorrect!'
  end

  def greaterThanOrEqualToTest card1, card2
    assert (card1 >= card2), 'Greater than comparison incorrect!'
  end

  def notGreaterThanOrEqualToTest card1, card2
    assertNot (card1 >= card2), 'Greater than comparison incorrect!'
  end

  def arrayEqualTest cards1, cards2
    assertEqual cards1, cards2, 'Card arrays should be equal!'
  end

  def arrayNotEqualTest cards1, cards2
    assertNotEqual cards1, cards2, 'Card arrays should not be equal!'
  end

  def arraySortTest cards, sorted
    assertEqual sorted, cards.sort, 'Sorted cards array incorrect!'
  end

  def to_sTest card, expected
    assertEqual expected, card.to_s, "#{card} should be expressed as #{expected}"
  end

  def to_strTest card, expected
    assertEqual expected, card.to_str, "#{card} should be expressed as #{expected}"
  end

  def canBeStrTest
    assertNothingRaised 'Should be able to use a Card as a String' do
      card = Card.new Suit::HEARTS, Card::ACE
      'string' + card
    end
  end
end

# Extend the class to add data providing functions
class CardTest
  def constantData
    [
      [   'ACE',     1],
      [  'JACK',    11],
      [ 'QUEEN',    12],
      [  'KING',    13],
      ['VALUES', 1..13],
    ]
  end

  def createValidCardData
    cards = []

    Suit::SUITS.each do |suit|
      (Card::ACE..Card::KING).each do |value|
        cards << [suit, value]
      end
    end

    cards
  end

  def createInvalidCardData
    [
      [           nil,       Card::ACE,  /^Invalid Suit/],
      [         false,               5,  /^Invalid Suit/],
      [          4242,              10,  /^Invalid Suit/],
      [        'Suit',      Card::KING,  /^Invalid Suit/],
      [          Card,               0,  /^Invalid Suit/],
      [  Suit::SPADES,            true, /^Invalid Value/],
      [  Suit::HEARTS, 'Ace of Spades', /^Invalid Value/],
      [Suit::DIAMONDS,            Card, /^Invalid Value/],
      [   Suit::CLUBS,             nil, /^Invalid Value/],
    ]
  end

  def faceCardData
    cards = []

    Suit::SUITS.each do |suit|
      (Card::JACK..Card::KING).each do |value|
        cards << [Card.new(suit, value)]
      end
    end

    cards
  end

  def notFaceCardData
    cards = []

    Suit::SUITS.each do |suit|
      (Card::ACE...Card::JACK).each do |value|
        cards << [Card.new(suit, value)]
      end
    end

    cards
  end

  def aceData
    cards = []
    Suit::SUITS.each do |suit|
      cards << [Card.new(suit, Card::ACE)]
    end
    cards
  end

  def notAceData
    cards = []

    Suit::SUITS.each do |suit|
      (2..Card::KING).each do |value|
        cards << [Card.new(suit, value)]
      end
    end

    cards
  end

  def spaceshipData
    [
      [   Card.new(Suit::CLUBS,  Card::ACE), Card.new(Suit::DIAMONDS,  Card::ACE), -1],
      [Card.new(Suit::DIAMONDS,          5),   Card.new(Suit::HEARTS,          5), -1],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::SPADES, Card::JACK), -1],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          7), -1],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          8), -1],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          9), -1],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS, Card::JACK), -1],
      [   Card.new(Suit::CLUBS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE),  0],
      [Card.new(Suit::DIAMONDS,          5), Card.new(Suit::DIAMONDS,          5),  0],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK),  0],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          2),  0],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          3),  0],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          4),  0],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS,          5),  0],
      [Card.new(Suit::DIAMONDS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE),  1],
      [  Card.new(Suit::HEARTS,          5), Card.new(Suit::DIAMONDS,          5),  1],
      [  Card.new(Suit::SPADES, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK),  1],
      [  Card.new(Suit::SPADES,          7),   Card.new(Suit::SPADES,          2),  1],
      [  Card.new(Suit::HEARTS,          8),   Card.new(Suit::HEARTS,          3),  1],
      [Card.new(Suit::DIAMONDS,          9), Card.new(Suit::DIAMONDS,          4),  1],
      [   Card.new(Suit::CLUBS, Card::JACK),    Card.new(Suit::CLUBS,          5),  1],
    ]
  end

  def lessThanTest
    [
      [   Card.new(Suit::CLUBS,  Card::ACE), Card.new(Suit::DIAMONDS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5),   Card.new(Suit::HEARTS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::SPADES, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          7)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          8)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          9)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS, Card::JACK)],
    ]
  end

  def notLessThanTest
    [
      [   Card.new(Suit::CLUBS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS,          5)],
      [Card.new(Suit::DIAMONDS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [  Card.new(Suit::HEARTS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::SPADES, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          7),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          8),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          9), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS, Card::JACK),    Card.new(Suit::CLUBS,          5)],
    ]
  end

  def lessThanOrEqualToData
    [
      [   Card.new(Suit::CLUBS,  Card::ACE), Card.new(Suit::DIAMONDS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5),   Card.new(Suit::HEARTS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::SPADES, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          7)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          8)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          9)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS, Card::JACK)],
      [   Card.new(Suit::CLUBS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS,          5)],
    ]
  end

  def notLessThanOrEqualToData
    [
      [Card.new(Suit::DIAMONDS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [  Card.new(Suit::HEARTS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::SPADES, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          7),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          8),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          9), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS, Card::JACK),    Card.new(Suit::CLUBS,          5)],
    ]
  end

  def equalTest
    [
      [   Card.new(Suit::CLUBS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS,          5)],
    ]
  end

  def notEqualTest
    [
      [   Card.new(Suit::CLUBS,  Card::ACE), Card.new(Suit::DIAMONDS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5),   Card.new(Suit::HEARTS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::SPADES, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          7)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          8)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          9)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS, Card::JACK)],
      [Card.new(Suit::DIAMONDS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [  Card.new(Suit::HEARTS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::SPADES, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          7),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          8),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          9), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS, Card::JACK),    Card.new(Suit::CLUBS,          5)],
    ]
  end

  def greaterThanData
    [
      [Card.new(Suit::DIAMONDS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [  Card.new(Suit::HEARTS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::SPADES, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          7),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          8),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          9), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS, Card::JACK),    Card.new(Suit::CLUBS,          5)],
    ]
  end

  def notGreaterThanData
    [
      [   Card.new(Suit::CLUBS,  Card::ACE), Card.new(Suit::DIAMONDS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5),   Card.new(Suit::HEARTS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::SPADES, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          7)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          8)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          9)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS, Card::JACK)],
      [   Card.new(Suit::CLUBS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS,          5)],
    ]
  end

  def greaterThanOrEqualToData
    [
      [   Card.new(Suit::CLUBS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS,          5)],
      [Card.new(Suit::DIAMONDS,  Card::ACE),    Card.new(Suit::CLUBS,  Card::ACE)],
      [  Card.new(Suit::HEARTS,          5), Card.new(Suit::DIAMONDS,          5)],
      [  Card.new(Suit::SPADES, Card::JACK),   Card.new(Suit::HEARTS, Card::JACK)],
      [  Card.new(Suit::SPADES,          7),   Card.new(Suit::SPADES,          2)],
      [  Card.new(Suit::HEARTS,          8),   Card.new(Suit::HEARTS,          3)],
      [Card.new(Suit::DIAMONDS,          9), Card.new(Suit::DIAMONDS,          4)],
      [   Card.new(Suit::CLUBS, Card::JACK),    Card.new(Suit::CLUBS,          5)],
    ]
  end

  def notGreaterThanOrEqualToData
    [
      [   Card.new(Suit::CLUBS,  Card::ACE), Card.new(Suit::DIAMONDS,  Card::ACE)],
      [Card.new(Suit::DIAMONDS,          5),   Card.new(Suit::HEARTS,          5)],
      [  Card.new(Suit::HEARTS, Card::JACK),   Card.new(Suit::SPADES, Card::JACK)],
      [  Card.new(Suit::SPADES,          2),   Card.new(Suit::SPADES,          7)],
      [  Card.new(Suit::HEARTS,          3),   Card.new(Suit::HEARTS,          8)],
      [Card.new(Suit::DIAMONDS,          4), Card.new(Suit::DIAMONDS,          9)],
      [   Card.new(Suit::CLUBS,          5),    Card.new(Suit::CLUBS, Card::JACK)],
    ]
  end

  def arrayEqualData
    [
      [
        [Card.new(Suit::SPADES, Card::ACE)],
        [Card.new(Suit::SPADES, Card::ACE)],
      ],
      [
        [Card.new(Suit::SPADES, Card::ACE), Card.new(Suit::HEARTS, 9), Card.new(Suit::CLUBS, Card::JACK)],
        [Card.new(Suit::SPADES, Card::ACE), Card.new(Suit::HEARTS, 9), Card.new(Suit::CLUBS, Card::JACK)],
      ],
    ]
  end

  def arrayNotEqualData
    [
      [
        [Card.new(Suit::SPADES, Card::ACE)],
        [Card.new(Suit::HEARTS, Card::ACE)],
      ],
      [
        [Card.new(Suit::SPADES, Card::ACE), Card.new(Suit::HEARTS, 9), Card.new(Suit::CLUBS, Card::JACK)],
        [Card.new(Suit::SPADES,         8), Card.new( Suit::CLUBS, 6), Card.new(Suit::CLUBS, Card::JACK)],
      ],
    ]
  end

  def arraySortData
    [
      [
        [Card.new(Suit::SPADES, Card::ACE)],
        [Card.new(Suit::SPADES, Card::ACE)],
      ],
      [
        [Card.new(Suit::SPADES, Card::JACK), Card.new(Suit::HEARTS,          9), Card.new( Suit::CLUBS, Card::JACK)],
        [Card.new(Suit::HEARTS,          9), Card.new( Suit::CLUBS, Card::JACK), Card.new(Suit::SPADES, Card::JACK)],
      ],
      [
        [Card.new(Suit::SPADES, Card::JACK), Card.new(Suit::HEARTS, 7), Card.new( Suit::CLUBS,  Card::ACE)],
        [Card.new( Suit::CLUBS,  Card::ACE), Card.new(Suit::HEARTS, 7), Card.new(Suit::SPADES, Card::JACK)],
      ],
    ]
  end

  def to_sData
    [
      [  Card.new(Suit::HEARTS,  1),  'A♥'],
      [   Card.new(Suit::CLUBS,  2),  '2♣'],
      [  Card.new(Suit::SPADES, 10), '10♠'],
      [Card.new(Suit::DIAMONDS, 11),  'J♦'],
      [  Card.new(Suit::HEARTS, 12),  'Q♥'],
      [   Card.new(Suit::CLUBS, 13),  'K♣'],
    ]
  end

  def to_strData
    to_sData
  end
end
