require "gem_builder"

RSpec.describe GemBuilder do
  subject { GemBuilder.new("spec/fixtures/fakegem") }

  describe "#version" do
    it "is read from the gemspec" do
      expect(subject.version).to eq(Gem::Version.new("13.3.7"))
    end
  end

  describe "#build_gem", stdout: false do
    let(:gem_path) { File.expand_path("spec/fixtures/fakegem/pkg/fake-gem-13.3.7.gem") }

    around(:each) do |example|
      FileUtils.rm_f(gem_path)
      example.run
      FileUtils.rm_f(gem_path)
    end

    it "creates the gem on disk" do
      expect {
        subject.build_gem
      }.to change { File.exists?(gem_path) }.to eq(true)
    end

    it "returns the path to the gem" do
      expect(subject.build_gem).to eq(gem_path)
    end
  end
end
