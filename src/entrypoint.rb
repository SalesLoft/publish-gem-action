#!/usr/bin/env ruby

puts ENV.map { |entry| entry.join(": ") }

puts "CWD: #{`pwd`}"

puts "git status"
system("git status")

puts "git branch -a"
system("git branch -a")
