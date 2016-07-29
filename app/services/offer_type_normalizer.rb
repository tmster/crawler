class OfferTypeNormalizer
  def initialize(name)
    @name = name
  end

  def call
    replace_phase
  end

  private

  attr_reader :name

  def replace_phase
    'Wynajem' if name == 'Mam do wynajęcia'
  end
end
