require_relative "app"

namespace "app" do
  desc "fetch database with an external source"
  task :fetch_db do
    app = App.new
    app.fetch

    records_amount = MongoService.instance.collection.count

    puts "Data was updated successfully"
    puts "Total: #{records_amount}"
  end
end
