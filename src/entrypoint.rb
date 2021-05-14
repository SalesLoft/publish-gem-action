#!/usr/bin/env ruby

puts ENV.map { |entry| entry.join(": ") }

def query(cmd)
  puts cmd
  system(cmd)
end

query("git remote -v")

query("git branch -a --contains")
