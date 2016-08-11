require "singleton"

class MongoService
  include Singleton

  def initialize
    begin
      @client = Mongo::Client.new(['127.0.0.1:27017'], database: "converter",
        server_selection_timeout: 5)

    rescue Mongo::Error => e
      puts "Error: #{e}"
    end
  end

  def collection
    @client[:rates]
  end
end
