class CustomError < StandardError
  attr_reader :klass

  def initialize(msg="Custom error", klass="Class")
    @klass = klass
    super msg
  end
end
