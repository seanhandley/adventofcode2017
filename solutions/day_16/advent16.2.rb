#!/usr/bin/env ruby

require_relative "./advent16.1"

@orderings = []

# Turns out there's only 30 combinations because it starts to repeat
trap "SIGINT" do
  puts @orderings.count
end

100.times do
  dance
  unless @orderings.include? programs
    @orderings << programs.dup
  end
end

i = 1_000_000_000 % @orderings.count

puts @orderings[i-1].join
