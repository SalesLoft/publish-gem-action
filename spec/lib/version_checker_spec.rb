require "version_checker"

RSpec.describe VersionChecker do
  subject { VersionChecker.new("1.0.0") }

  describe "assert_version!" do
    it "raises an error on version mismatch" do
      version = Gem::Version.new("1.0.0.pre1")
      expect {
        subject.assert_version!(version)
      }.to raise_error(VersionChecker::VersionMismatch)
    end

    it "does nothing on a matching version" do
      version = Gem::Version.new("1.0.0")
      subject.assert_version!(version)
    end
  end
end
