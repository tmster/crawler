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
    'Mieszkanie' if name.downcase == 'mieszkanie na wynajem'
  end
end
