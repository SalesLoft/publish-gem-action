#!/usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path("lib", File.dirname(__FILE__))

require "gem_builder"
require "input"
require "github_vars"
require "output"

begin
  input = Input.new.tap(&:validate!)
  github_vars = GithubVars.new.tap(&:validate!)
  builder = GemBuilder.new(input.working_directory)
  version = builder.version

  input.branch_checker.require_default_branch! unless version.prerelease?
  github_vars.version_checker.assert_version!(version)


  puts "Building gem"
  gem = builder.build_gem

  puts "Uploading gem"
  input.gem_repo.upload(gem)

  puts "Successfully published #{version}!"

rescue KingKonf::ConfigError => e
  Output.error "Configuration Error: #{e}"
  exit -1
rescue BranchChecker::InvalidBranch => e
  Output.error "Invalid Branch: #{e}"
  exit -1
rescue VersionChecker::VersionMismatch => e
  Output.error "Version Mismatch: #{e}"
  exit -1
rescue GemRepo::UploadFailed => e
  Output.error "An error occurred while uploading the gem: #{e}"
  exit -1
end
