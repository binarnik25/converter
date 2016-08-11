module Converter
  def convert(amount, date)
    begin
      iso_date = Date.parse date
      amount = amount.to_i

      converter = self.new amount, iso_date

      if converter.date_is_greater?
        raise CustomError.new("cannot look into the future", "#{self}")
      elsif converter.date_is_less?
        raise CustomError.new("cannot look into the past", "#{self}")
      elsif converter.find_rate.nil?
        if converter.is_today?
          raise CustomError.new("today the rate hasn't been provided yet",
            "#{self}")
        else
          raise CustomError.new("need to fetch database by rake task", "#{self}")
        end
      end

    rescue CustomError => e
      puts "Custom Error: #{e}. #{e.klass}"
    rescue TypeError, Mongo::Error => e
      puts "Error: #{e}"
    else
      converter.result
    end
  end
end
