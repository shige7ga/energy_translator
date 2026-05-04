class TranslationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :input, :float
  attribute :conversion_id, :integer

  validates :input, presence: true, numericality: { greater_than: 0 }
  validates :conversion_id, presence: true
  validate :conversion_must_exist

  def result
    return nil unless valid?
    conversion.translate(input)
  end

  def conversion
    @conversion ||= Conversion.find_by(id: conversion_id)
  end

  private

  def conversion_must_exist
    return if conversion_id.blank?
    return if conversion.present?

    errors.add(:conversion_id, :not_found)
  end
end
