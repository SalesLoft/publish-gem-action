class VersionChecker
  VersionMismatch = Class.new(StandardError)

  attr_reader :expected_version
  def initialize(expected_version)
    @expected_version = Gem::Version.new(expected_version)
  end

  def assert_version!(version)
    return if version == expected_version
    raise VersionMismatch.new("Expecting to build #{expected_version} but gem is at #{version}")
  end
end
