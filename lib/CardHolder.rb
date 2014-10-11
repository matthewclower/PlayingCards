require_relative 'Card'

module CardHolder
  protected
  @cards
  
  protected
  def cards= cards
    raise ArgumentError, "Cards must be an array" unless cards.is_a? Array
    if !cards.empty?
      cards.each do |card|
        raise ArgumentError, "Cards must be an array fo Cards" unless card.is_a? Card
      end
    end

    @cards = cards.clone
  end

  public
  # string methods
  def to_s
    s = ''
    @cards.each do |card|
      s = "#{s} #{card}"
    end
    s.strip
  end

  def to_str
    to_s
  end
end
