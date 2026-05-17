class EnergyUnit < ApplicationRecord
  validates :name, presence: true
  validates :to_joule, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :formula_text, presence: true
  validates :reference_url, presence: true
end
