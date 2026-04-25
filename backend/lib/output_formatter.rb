class OutputFormatter
  def self.call(res)
    "#{JSON.pretty_generate(res)}\n"
  end
end
