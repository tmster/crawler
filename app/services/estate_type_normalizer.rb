class EstateTypeNormalizer
  def initialize(name)
    @name = name
  end

  def call
    replace_phase
  end

  private

  attr_reader :name

  def replace_phase
    return 'Mieszkanie' if name && name.downcase == 'mieszkanie na wynajem'
    return 'Mieszkanie' if name && name.downcase == 'mieszkanie na sprzedaż'
    return 'Dom' if name && name.downcase == 'dom na wynajem'
    return 'Dom' if name && name.downcase == 'dom na sprzedaż'
  end
end
