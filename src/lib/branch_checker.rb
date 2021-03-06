class BranchChecker
  InvalidBranch = Class.new(StandardError)

  attr_reader :default_branch_name
  def initialize(default_branch_name)
    @default_branch_name = default_branch_name
  end

  def on_default_branch?
    system("git fetch origin #{default_branch_name}")
    system(%{git branch -a --contains | grep -q "^  remotes/origin/#{default_branch_name}$"})
  end

  def require_default_branch!
    return if on_default_branch?
    raise InvalidBranch.new("Releases must be made against #{default_branch_name}")
  end
end
