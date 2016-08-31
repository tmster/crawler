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
    return 'Wynajem' if name == 'Mam do wynajęcia'
    return 'Wynajem' if name && name.downcase == 'mieszkanie na wynajem'
  end
end
