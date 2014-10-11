require 'Suit'

class SuitTest < RubyUnit::TestCase
  def constantTest konstant, value
    assertConst value, Suit, konstant, "Suit constant #{konstant} is not the right value!"
  end

  def validSuitsTest suit
    assert Suit::valid?(suit), "#{suit} should be a valid Suit"
  end
  
  def invalidSuitsTest suit
    assertNot Suit::valid?(suit), "#{suit} should not be a valid Suit"
  end
end

# Extend the class to add data providing functions
class SuitTest
  def constantData
    [
      [  'SPADES',         0],
      [  'HEARTS',         1],
      ['DIAMONDS',         2],
      [   'CLUBS',         3],
      [   'SPADE',       '♠'],
      [   'HEART',       '♥'],
      [ 'DIAMOND',       '♦'],
      [    'CLUB',       '♣'],
      [   'SUITS', [0,1,2,3]],
    ]
  end

  def validSuitsData
    [
      [  Suit::SPADES],
      [  Suit::HEARTS],
      [Suit::DIAMONDS],
      [   Suit::CLUBS],
    ]
  end

  def invalidSuitsData
    [
      [ false],
      [   1.5],
      [  4242],
      ['text'],
    ]
  end
end
