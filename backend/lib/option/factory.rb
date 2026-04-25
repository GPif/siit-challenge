module Option
  class Factory
    def self.create(option_type)
      case option_type
      when 'gps'
        Option::Gps.new
      when 'baby_seat'
        Option::BabySeat.new
      when 'additional_insurance'
        Option::AdditionalInsurance.new
      else
        raise ArgumentError, "Unknown option type: #{option_type}"
      end
    end
  end
end
