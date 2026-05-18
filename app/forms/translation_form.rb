class TranslationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :input, :float
  attribute :conversion_id, :integer
  attribute :energy_unit_id, :integer

  validates :input, presence: true, numericality: { greater_than: 0 }
  validates :conversion_id, presence: true
  validates :energy_unit_id, presence: true
  validate :conversion_must_exist
  validate :energy_unit_must_exist

  def result_for_display
    if conversion.output_unit == "分"
      minutes_to_hours_minutes(result)
    else
      result.to_s + conversion.output_unit
    end
  end

  def result
    return nil unless valid?
    kcal_input = energy_unit.to_kcal(input)
    conversion.translate(kcal_input)
  end

  def conversion
    @conversion ||= Conversion.find_by(id: conversion_id)
  end

  def energy_unit
    @energy_unit ||= EnergyUnit.find_by(id: energy_unit_id)
  end

  private

  def minutes_to_hours_minutes(total_minutes)
    return "#{total_minutes}分" if total_minutes < 60
    hours, minutes = total_minutes.divmod(60)
    "#{hours}時間#{minutes}分"
  end

  def conversion_must_exist
    record_must_exist(:conversion_id, conversion)
  end

  def energy_unit_must_exist
    record_must_exist(:energy_unit_id, energy_unit)
  end

  def record_must_exist(attribute, record)
    return if record.present?
    errors.add(attribute, :not_found)
  end
end
