require 'CardHolder'

class CardHolderTest < RubyUnit::TestCase
  # TODO update this with a fixture...
  include CardHolder

  def validCardsAssignTest cards
    assertNothingRaised "Should be able to assign array of cards" do
      self.cards = cards
    end
  end

  def invalidCardsAssignTest cards, message
    assertRaiseExpected ArgumentError, message, "Should not be able to assign invalid array of Cards" do
      self.cards = cards
    end
  end

  def to_sTest cards, expected
    self.cards = cards
    assertEqual expected, to_s, "#{to_s} should be expressed as #{expected}"
  end
  
  def to_strTest cards, expected  
    self.cards = cards
    assertEqual expected, to_s, "#{to_s} should be expressed as #{expected}"
  end

  def canBeStrTest
    assertNothingRaised "Should be able to use a CardHolder as a String" do
      self.cards = [Card.new(Suit::HEARTS,1)]
      s          = 'string' + self
    end
  end

  def cloneCardsTest cards
    self.cards = cards

    assertNotSame cards, @cards, "Cards should not be the original object"
  end
end

class CardHolderTest
  def validCardsAssignData
    [
      [[Card.new(Suit::HEARTS,1)]],
      [[Card.new(Suit::SPADES,1),Card.new(Suit::HEARTS,5),Card.new(Suit::DIAMONDS,9),Card.new(Suit::CLUBS,13)]],
      [[Card.new(Suit::CLUBS,6),Card.new(Suit::CLUBS,7),Card.new(Suit::CLUBS,8),Card.new(Suit::CLUBS,9),Card.new(Suit::CLUBS,10)]],
    ]
  end

  def invalidCardsAssignData
    [
      [  true, 'Cards must be an array'],
      ['text', 'Cards must be an array'],
      [  4242, 'Cards must be an array'],
      [   nil, 'Cards must be an array'],

      [
        [Card.new(Suit::HEARTS,1), true],
        'Cards must be an array fo Cards',
      ],
      [
        [Card.new(Suit::SPADES,1),Card.new(Suit::HEARTS,5),Card.new(Suit::DIAMONDS,9),'text',Card.new(Suit::CLUBS,13)],
        'Cards must be an array fo Cards',
      ],
      [
        [Card.new(Suit::CLUBS,6),Card.new(Suit::CLUBS,7),Card.new(Suit::CLUBS,8),4242,Card.new(Suit::CLUBS,9),Card.new(Suit::CLUBS,10)],
        'Cards must be an array fo Cards',
      ],
      [
        [nil, Card.new(Suit::HEARTS,1), true],
        'Cards must be an array fo Cards',
      ],
    ]
  end

  def to_sData
    [
      [
        [Card.new(Suit::HEARTS,1)],
        "A♥",
      ],
      [
        [Card.new(Suit::SPADES,1),Card.new(Suit::HEARTS,5),Card.new(Suit::DIAMONDS,9),Card.new(Suit::CLUBS,13)],
        "A♠ 5♥ 9♦ K♣",
      ],
      [
        [Card.new(Suit::CLUBS,6),Card.new(Suit::CLUBS,7),Card.new(Suit::CLUBS,8),Card.new(Suit::CLUBS,9),Card.new(Suit::CLUBS,10)],
        "6♣ 7♣ 8♣ 9♣ 10♣",
      ],
    ]
  end

  def to_strData
    to_sData
  end

  def cloneCardsData
    validCardsAssignData
  end

end
