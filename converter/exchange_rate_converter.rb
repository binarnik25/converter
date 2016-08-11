class ExchangeRateConverter
  extend Converter

  def initialize(amount, date)
    @amount, @date = amount, date
  end

  def date_is_greater?
    @date > Date.today
  end

  def date_is_less?
    @date < Date.parse("2000-01-03")
  end

  def is_today?
    @date == Date.today
  end

  def find_rate
    @rate = MongoService.instance.collection.find(
      {
        "date": {
          "$lte": @date
        }
      })
      .sort({_id:-1})
      .first[:rate].to_f
  end

  def result
    (@amount * @rate).round 2
  end
end
