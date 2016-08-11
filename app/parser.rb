class Parser
  DEFAULT_DATE_REGEX = /^2\d{3}-\d{2}-\d{2},\d.\d{4}\r\n$/

  def initialize(line)
    @line = line
  end

  def is_default_date?
    DEFAULT_DATE_REGEX.match @line
  end

  def is_last_date?
    get_last_record
    @last_date_regex.match @line if @last_record
  end

  def date
    Date.parse(@line[0..9])
  end

  def rate
    @line[11..16]
  end

  private

  def get_last_record
    collection = MongoService.instance.collection
    @last_record = collection.find({}).sort(_id: -1).limit(1).first
    get_last_date_regex if @last_record
  end

  def get_last_date_regex
    year =  @last_record[:date].year
    month = ("0" +  @last_record[:date].month.to_s)[-2..-1]
    day = ("0" +  @last_record[:date].day.to_s)[-2..-1]

    @last_date_regex = /^#{year}-#{month}-#{day},\d.\d{4}\r\n$/
  end
end
