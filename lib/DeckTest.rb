require_relative 'Deck'

class DeckTest < RubyUnit::TestCase
  def createValidDeckTest decks
    deck = Deck.new decks
    assertInstanceOf Deck, deck, 'Deck must be instance of Deck'
  end

  def createDefaultDeckTest
    deck = Deck.new
    assertInstanceOf Deck, deck, 'Deck must be instance of Deck'
    assertEqual 52, deck.cards.count, 'Default deck should have 52 cards'
  end

  def createInvalidDeckTest decks, message
    assertRaiseExpected ArgumentError, message, 'Should not be able to create a Deck with invalid number of decks' do
      deck = Deck.new decks
    end
  end

  def cloneIsNotSameTest
    deck = Deck.new
    new_deck = deck.clone
    assertNotSame new_deck, deck, 'Clone of Deck should be a different object'
  end

  def validPlaceTest decks, place
    deck = Deck.new decks
    deck.send :place=, place
    assertEqual place, deck.instance_variable_get('@place'), "@place should have been updated to #{place}"
  end

  def invalidPlaceTest decks, place, message
    assertRaiseExpected ArgumentError, message, 'Should not be able to update @place to an invalid value' do
      deck = Deck.new
      deck.send :place=, place
    end
  end

  def dealtTest decks, draws
    deck = Deck.new decks
    dealt = []
    draws.times do
      dealt << deck.draw_card
    end
    assertEqual dealt, deck.send(:dealt), 'Cards dealt do not match!'
  end

  def cardsTest decks, draws
    deck = Deck.new decks
    cards = deck.cards
    draws.times do
      deck.draw_card
    end
    assertEqual cards.slice(draws..cards.count), deck.cards, 'Cards in deck do not match!'
  end

  def shuffleTest decks, draws
    deck = Deck.new decks
    draws.times do
      deck.draw_card
    end
    cards = deck.cards
    deck.shuffle!
    assertNotEqual cards, deck.cards, 'Shuffled deck should be different!'
  end

  def drawCardTest decks
    deck = Deck.new decks
    count = decks * 52
    (0...count).each do |i|
      # draw all cards
      assertEqual (count - i), deck.cards.count, 'card count is incorrect!'
      assertInstanceOf Card, deck.draw_card, 'draw_card should return a Card object!'
    end
    assertEqual count, deck.cards.count, 'drawing all cards should reshuffle the deck!'
    assertInstanceOf Card, deck.draw_card, 'should be able to draw a new deck!'
  end

  def invalidDrawTest draws, pattern
    deck = Deck.new
    assertRaiseExpected ArgumentError, pattern, 'Should not be able to draw invalid number of cards' do
      deck.draw draws
    end
  end

  def validDrawTest draws
    deck = Deck.new
    cards = deck.draw draws
    assertEqual draws, cards.count, 'draw returned the wrong number of Cards!'
    cards.each do |card|
      assertInstanceOf Card, card, 'draw should return an array of Cards!'
    end
  end

  def resetTest decks, draws
    deck = Deck.new decks
    deck.draw draws
    deck.reset
    assertEqual (decks * 52), deck.cards.count, 'reset should shuffle all cards back into the deck!'
  end
end

class DeckTest
  def createValidDeckData
    [
      [ 1],
      [42],
    ]
  end

  def createInvalidDeckData
    [
      [    -1, /^Invalid number of decks/],
      [     0, /^Invalid number of decks/],
      [   1.5, /^Invalid number of decks/],
      ['text', /^Invalid number of decks/],
    ]
  end

  def validPlaceData
    [
      [1,   0],
      [1,   1],
      [1,  42],
      [1,  51],
      [2, 100],
    ]
  end

  def invalidPlaceData
    [
      [1,             -1,   'Place is out of bounds'],
      [1,             52,   'Place is out of bounds'],
      [1,            100,   'Place is out of bounds'],
      [1, Rational(10/1), 'Place must be an integer'],
      [1,       'string', 'Place must be an integer'],
    ]
  end

  def dealtData
    [
      [1,   0],
      [1,   1],
      [1,   2],
      [1,   4],
      [1,   8],
      [1,  16],
      [1,  32],
      [2,   0],
      [2,   1],
      [2,   2],
      [2,   4],
      [2,   8],
      [2,  16],
      [2,  32],
      [2,  64],
    ]
  end

  def cardsData
    dealtData
  end

  def shuffleData
    [
      [1,   0],
      [1,   1],
      [1,   2],
      [1,   4],
      [1,   8],
      [1,  16],
      [1,  32],
      [2,   0],
      [2,   1],
      [2,   2],
      [2,   4],
      [2,   8],
      [2,  16],
      [2,  32],
      [2,  64],
    ]
  end

  def drawCardData
    [
      [1],
      [2],
    ]
  end

  def validDrawData
    [
      [ 1],
      [ 2],
      [ 4],
      [ 8],
      [16],
      [32],
      [64],
    ]
  end

  def invalidDrawData
    [
      [      'string', /^Number of cards must be an Integer/],
      [          10.5, /^Number of cards must be an Integer/],
      [Rational(10/1), /^Number of cards must be an Integer/],
      [          Card, /^Number of cards must be an Integer/],
      [             0,    'Number of cards must be positive'],
      [           -42,    'Number of cards must be positive'],
    ]
  end

  def resetData
    [
      [1,   1],
      [1,   2],
      [1,   4],
      [1,   8],
      [1,  16],
      [1,  32],
      [2,   1],
      [2,   2],
      [2,   4],
      [2,   8],
      [2,  16],
      [2,  32],
      [2,  64],
    ]
  end
end
