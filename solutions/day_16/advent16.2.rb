#!/usr/bin/env ruby

require_relative "./advent16.1"

@orderings = []

trap "SIGINT" do
  # Using this to debug, we can see how many orderings are found
  puts @orderings.count
end

# After 100 iterations, we see there's only 30 combinations
# and then the sequence repeats
100.times do
  dance
  unless @orderings.include? programs
    @orderings << programs.dup
  end
end

# Since there's only 30 combinations, we can
# use modulus to find the correct ordering.
i = 1_000_000_000 % @orderings.count

puts @orderings[i-1].join
