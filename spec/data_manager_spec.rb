require "./app"

RSpec.describe DataManager do
  describe ".update_records" do
    collection = MongoService.instance.collection

    context "when database is empty" do
      before { collection.drop }

      it "should add new records to empty database" do
        expect { DataManager.update_records }.to change { collection.count }
          .by_at_least(100)
      end
    end

    context "when database is up-to date" do
      let!(:total) { collection.count }

      before { DataManager.update_records }

      it "should check updating procedure is idempotent" do
        expect { DataManager.update_records }.to change { total }.by(0)
      end
    end
  end
end
