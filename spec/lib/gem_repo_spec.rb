require "gem_repo"

RSpec.describe GemRepo do
  subject { GemRepo.new("https://salesloft:hunter2@gems.example.com/upload") }

  describe "#upload" do
    it "executes the correct curl command", stdout: false do
      expect(IO).to receive(:popen).with(
        "curl -sS --fail --form \"file=@path/to/file.gem\" https://salesloft:hunter2@gems.example.com/upload"
      ).and_return(IO.popen("echo Gem fake-gem-13.3.7.gem received and indexed."))

      subject.upload("path/to/file.gem")
    end

    it "raises an error if the response string contains an error" do
      allow(IO).to receive(:popen).and_return(IO.popen("echo 409Updating an existing gem is not permitted."))

      expect {
        subject.upload("path/to/file.gem")
      }.to raise_error(GemRepo::UploadFailed)
    end

    it "raises an error on failure" do
      allow(IO).to receive(:popen).and_return(IO.popen("false"))

      expect {
        subject.upload("path/to/file.gem")
      }.to raise_error(GemRepo::UploadFailed)
    end
  end
end
