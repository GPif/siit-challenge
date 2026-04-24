Action = Struct.new(:who, :type, :amount) do
  def to_h = { who: who, type: type, amount: amount }
end
