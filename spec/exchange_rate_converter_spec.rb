require "./app"

RSpec.describe ExchangeRateConverter do
  describe ".convert" do
    subject do
      lambda { |amount, date| ExchangeRateConverter.convert amount, date }
    end

    context "real data" do
      it { expect(subject.call(100, "2000-12-25")).to eq 92.40 }
      it { expect(subject.call(100, "2008-03-21")).to eq 154.23 }
      it { expect(subject.call(100, "2009-06-18")).to eq 139.20 }
      it { expect(subject.call(100, "2005-12-26")).to eq 118.59 }
      it { expect(subject.call(100, "2011-08-18")).to eq 143.69 }
      it { expect(subject.call(100, "2013-06-20")).to eq 132.00 }
      it { expect(subject.call(100, "2016-08-08")).to eq 110.87 }
    end
  end

  describe do
    subject do
      lambda { |amount, date| ExchangeRateConverter.new amount, date }
    end

    describe "#date_is_greater?" do
      it "should check is date from future because rates are absent" do
        expect(subject.call(100, Date.today + 1).date_is_greater?).to be true
        expect(subject.call(100, Date.today + 100).date_is_greater?).to be true
        expect(subject.call(100, Date.today).date_is_greater?).to be false
        expect(subject.call(100, Date.today - 1).date_is_greater?).to be false
      end
    end

    describe "#date_is_less?" do
      it "should check is date before 2000" do
        expect(subject.call(100, Date.parse("1999-02-02")).date_is_less?)
          .to be true
        expect(subject.call(100, Date.parse("2000-02-02")).date_is_less?)
          .to be false
      end
    end

    describe "#find_rate" do
      it "should return float rate value from database" do
        expect(subject.call(100, Date.today).find_rate).to be > 0
        expect(subject.call(100, Date.today - 100).find_rate).to be > 0
      end
    end

    describe "#is_today?" do
      it "should check if date is today" do
        expect(subject.call(100, Date.today).is_today?).to be true
        expect(subject.call(100, Date.today + 1).is_today?).to be false
      end
    end

    describe "#result" do
      amount = 100
      let(:result) { subject.call(amount, Date.today - 1).find_rate * amount }
      let(:converter) { subject.call(amount, Date.today - 1) }

      before { converter.find_rate }

      it "should return the result of multiplying the rate on the amount" do
        expect(converter.result).to eq result.round 2
        expect(converter.result.to_s.split(".")[1].length).to eq 2
      end
    end
  end
end
