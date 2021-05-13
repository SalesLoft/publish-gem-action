require "branch_checker"

RSpec.describe BranchChecker do
  subject { BranchChecker.new("master") }

  describe "#on_default_branch?" do
    it "executes the correct commands" do
      expect(subject).to receive(:system).with(
        "git fetch origin/master"
      )
      expect(subject).to receive(:system).with(
        "git branch --contains | grep -q origin/master"
      )

      subject.on_default_branch?
    end
  end

  describe "#require_default_branch!" do
    it "raises an error when not on the default branch" do
      allow(subject).to receive(:system).and_return(false)

      expect {
        subject.require_default_branch!
      }.to raise_error(BranchChecker::InvalidBranch)
    end

    it "does nothing when on the default branch" do
      allow(subject).to receive(:system).and_return(true)

      subject.require_default_branch!
    end
  end
end
