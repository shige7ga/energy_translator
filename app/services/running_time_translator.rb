class RunningTimeTranslator
  KCAL_PER_MIN = 8.3

  def self.call(kcal)
    (kcal.to_f / KCAL_PER_MIN).round
  end
end
