#!/usr/bin/env ruby

def steps
  @steps ||= STDIN.read.to_i
end

def limit
  50_000_000
end

def buffer
  @buffer ||= [0]
end

trap "SIGINT" do
  puts buffer.length
  puts buffer[1]
end

# Because inserts get more expensive as an array
# grows, we only insert elements that will be placed
# in position 1 (position 0 is always 0). All other
# elements can simply be pushed to the end of the
# array, which gives us a linear time complexity
# rather than quadratic.
def calculate
  move = 0
  (1..limit).each do |n|
    move = (move+steps) % buffer.length + 1
    move == 1 ? buffer.insert(1, n) : buffer.push(n)
  end
  buffer[1]
end

p calculate
