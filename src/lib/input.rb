require "king_konf"
require "branch_checker"
require "gem_repo"


class Input < KingKonf::Config
  env_prefix :input

  desc "Authenticated upload URL for our gem repo"
  string :gem_repo_url, required: true

  desc "The name of this repository's default branch"
  string :default_branch_name, required: true

  desc "The directory that contains the gem to publish"
  string :working_directory, required: true

  def gem_repo
    @gem_repo ||= GemRepo.new(gem_repo_url)
  end

  def branch_checker
    @branch_checker ||= BranchChecker.new(default_branch_name)
  end
end
