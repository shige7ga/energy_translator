class Conversion < ApplicationRecord
  enum calculation_type: { divide: 0, multiply: 1 }

  validates :name, presence: true
  validates :category, presence: true
  validates :input_unit, presence: true
  validates :output_unit, presence: true
  validates :factor, presence: true, numericality: { greater_than: 0 }
  validates :calculation_type, presence: true

  def translate(input)
    result = if divide?
      input / factor
    elsif multiply?
      input * factor
    else
      raise '未対応の計算タイプです'
    end
    result.round
  end
end
