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
    return 'Wynajem' if name &&  name.downcase == 'dom na wynajem'
    return 'Sprzedaż' if name && name.downcase == 'mieszkanie na sprzedaż'
    return 'Sprzedaż' if name &&  name.downcase == 'dom na sprzedaż'
  end
end
