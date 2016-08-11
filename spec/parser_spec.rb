require "./app"

RSpec.describe Parser do
  subject do
     lambda { |line| Parser.new line }
  end

  describe "#is_default_date?" do
    it "should check the date and the line are valid" do
      expect(subject.call("2016-08-04,1.1136\r\n").is_default_date?)
        .not_to be_nil
      expect(subject.call("2016-08-04,-\r\n").is_default_date?).to be nil
      expect(subject.call("1999-08-04,1.1136\r\n").is_default_date?).to be nil
    end
  end

  describe "#is_last_date?" do
    collection = MongoService.instance.collection

    before do
      collection.insert_one({ date: Date.parse("2016-01-01"), rate: "1.1111" })
    end

    it "should check is parsed line of the last record" do
      expect(subject.call("2016-01-01,1.1111\r\n").is_last_date?).not_to be nil
      expect(subject.call("2015-04-01,1.1111\r\n").is_last_date?).to be nil
    end

    after do
      last_record = collection.find({}).sort({_id:-1}).limit(1).first
      collection.delete_one last_record
    end
  end

  describe "#date" do
    it "should return parsed date from file line" do
      expect(subject.call("2016-01-01,1.1111\r\n").date)
        .to eq Date.parse("2016-01-01")
    end
  end

  describe "#rate" do
    it "should return rate substring from file line" do
      expect(subject.call("2016-01-01,1.1111\r\n").rate)
        .to eq "1.1111"
    end
  end
end
