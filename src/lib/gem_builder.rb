require "bundler"

class GemBuilder
  attr_reader :gem_path

  def initialize(gem_path)
    @gem_path = File.expand_path(gem_path)
  end

  def version
    gemspec.version
  end

  def build_gem
    gemhelper.build_gem
  end

  private

  def gemspec
    gemhelper.gemspec
  end

  def gemhelper
    @gemhelper ||= Bundler::GemHelper.new(gem_path)
  end
end
