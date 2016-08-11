require "net/http"

class Downloader

  def make_request
    @resp = Net::HTTP.start("sdw.ecb.europa.eu") do |http|
      http.get("/export.do?type=&trans=N&node=2018794&CURRENCY=" +
        "USD&FREQ=D&start=01­01­2012&q=&submitOptions.y=6&submitOptions." +
        "x=51&sfl1=4&end=&SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&sfl3=4&D" +
        "ATASET=0&exportType=csv")
    end
  end

  def is_valid_response?
    @resp.code === "200" && @resp.content_type === "text/csv"
  end

  def file_data
    @resp.body
  end

  def self.update_csv_file
    begin
      downloader = self.new
      downloader.make_request

      if downloader.is_valid_response?
        open("data/data.csv", "wb") { |file| file.write downloader.file_data }
      else
        raise CustomError.new("invalid parameters of URL", "#{self.class}")
      end

    rescue CustomError => e
      puts "Custom Error: #{e}. #{e.klass}"
    rescue SocketError, Errno => e
      puts "Error: #{e}"
    end
  end
end
