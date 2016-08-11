class DataManager

  def self.update_records
    documents = []

    begin
      open("data/data.csv").readlines.each do |line|
        parser = Parser.new line

        next unless parser.is_default_date?
        break if parser.is_last_date?

        documents.push({ date: parser.date, rate: parser.rate })
      end

      MongoService.instance.collection.insert_many documents.reverse
    rescue Errno, Mongo::Error => e
      puts "Error: #{e}"
    end
  end
end
