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

  def to_sTest card, expected
    assertEqual expected, card.to_s, "#{card} should be expressed as #{expected}"
  end

  def to_strTest card, expected
    assertEqual expected, card.to_str, "#{card} should be expressed as #{expected}"
  end

  def canBeStrTest
    assertNothingRaised 'Should be able to use a Card as a String' do
      card = Card.new Suit::HEARTS, 1
      'string' + card
    end
  end
end

# Extend the class to add data providing functions
class CardTest
  def constantData
    [
      ['MIN_VALUE',     1],
      ['MAX_VALUE',    13],
      [   'VALUES', 1..13],
    ]
  end

  def createValidCardData
    cards = []

    Suit::SUITS.each do |suit|
      (1..13).each do |value|
        cards << [suit, value]
      end
    end

    cards
  end

  def createInvalidCardData
    [
      [           nil,               1,  /^Invalid Suit/],
      [         false,               5,  /^Invalid Suit/],
      [          4242,              10,  /^Invalid Suit/],
      [        'Suit',              13,  /^Invalid Suit/],
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
      (11..13).each do |value|
        cards << [Card.new(suit, value)]
      end
    end

    cards
  end

  def notFaceCardData
    cards = []

    Suit::SUITS.each do |suit|
      (1..10).each do |value|
        cards << [Card.new(suit, value)]
      end
    end

    cards
  end

  def aceData
    cards = []
    Suit::SUITS.each do |suit|
      cards << [Card.new(suit, 1)]
    end
    cards
  end

  def notAceData
    cards = []

    Suit::SUITS.each do |suit|
      (2..13).each do |value|
        cards << [Card.new(suit, value)]
      end
    end

    cards
  end

  def to_sData
    [
      [   Card.new(Suit::HEARTS, 1),  'A♥'],
      [    Card.new(Suit::CLUBS, 2),  '2♣'],
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
