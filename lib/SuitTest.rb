require_relative 'Suit'

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
      [   'CLUBS',         0],
      ['DIAMONDS',         1],
      [  'HEARTS',         2],
      [  'SPADES',         3],
      [   'SPADE',       '♠'],
      [   'HEART',       '♥'],
      [ 'DIAMOND',       '♦'],
      [    'CLUB',       '♣'],
      [   'SUITS', [3,2,1,0]],
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
