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

def calculate
  move = 0
  (1..limit).each do |n|
    move = (move+steps) % buffer.length + 1
    move == 1 ? buffer.insert(1, n) : buffer.push(n)
  end
  buffer[1]
end

p calculate
