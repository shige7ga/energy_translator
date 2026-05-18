class EnergyUnit < ApplicationRecord
  validates :name, presence: true
  validates :to_joule, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :formula_text, presence: true
  validates :reference_url, presence: true

  def to_kcal(input)
    return input if name == 'kcal'
    joule = input * to_joule # J換算
    kcal_to_joule = 4184 # 1kcal = 4184J
    (joule / kcal_to_joule).ceil(4)
  end
end
