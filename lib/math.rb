module Math
  def percentage(numerator, denominator)
    (numerator / denominator.to_f).round(2)
  end
end