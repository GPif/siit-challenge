module NumericHelper
  def numeric_format(n)
    n == n.to_i ? n.to_i : n
  end
end
