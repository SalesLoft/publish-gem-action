require "king_konf"
require "version_checker"

class GithubVars < KingKonf::Config
  env_prefix :github
  ignore_unknown_variables true

  desc "The tag that triggered this build"
  string :ref, required: true, validate_with: ->(ref) { ref.start_with?("refs/tags/v") }

  def version_checker
    @version_checker ||= VersionChecker.new(ref.delete_prefix("refs/tags/v"))
  end
end
