require "./app"

RSpec.describe Downloader do
  describe ".update_csv_file" do
    before do
      FileUtils.rm('data/data.csv')
      Downloader.update_csv_file
    end

    it { expect(File.file? "data/data.csv").to be true }
  end
end
