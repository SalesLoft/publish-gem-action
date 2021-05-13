#!/usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path("lib", File.dirname(__FILE__))

require "gem_builder"
require "input"
require "github_vars"

begin
  input = Input.new
  github_vars = GithubVars.new
  builder = GemBuilder.new(Dir.pwd)
  version = builder.version

  input.validate!
  github_vars.validate!
  input.branch_checker.require_default_branch! unless version.prerelease?
  github_vars.version_checker.assert_version!(version)


  puts "Building gem"
  gem = builder.build_gem

  puts "Uploading gem"
  input.gem_repo.upload(gem)

  puts "Successfully published #{version}!"

rescue KingKonf::ConfigError => e
  $stderr.puts "Configuration Error: #{e}"
  exit -1
rescue BranchChecker::InvalidBranch => e
  $stderr.puts "Invalid Branch: #{e}"
  exit -1
rescue VersionChecker::VersionMismatch => e
  $stderr.puts "Version Mismatch: #{e}"
  exit -1
rescue GemRepo::UploadFailed => e
  $stderr.puts "An error occurred while uploading the gem: #{e}"
  exit -1
end
