require "mongo"
require_relative "utilities/custom_error"
require_relative "utilities/mongo_service"
require_relative "app/downloader"
require_relative "app/data_manager"
require_relative "app/parser"
require_relative "converter/converter"
require_relative "converter/exchange_rate_converter"

class App

  def initialize
    Downloader.update_csv_file
  end

  def fetch
    DataManager.update_records
  end
end
