module Math
  def percentage(numerator, denominator, float = 2)
    (numerator / denominator.to_f).round(float)
  end
end