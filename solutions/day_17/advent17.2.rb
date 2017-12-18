#!/usr/bin/env ruby

def steps
  @steps ||= STDIN.read.to_i
  37
end

def limit
  20
end

def buffer
  @buffer ||= [0]
end

trap "SIGINT" do
  puts buffer.length
  puts buffer[buffer.find_index(0)+1]
end

def calculate
  (1..limit).each do |n|
    zero_index = buffer.find_index(0)
    move = (zero_index+steps) % buffer.length
    if move == zero_index+1
      buffer.insert(move, n)
    elsif move > zero_index
      buffer << n
    else
      buffer.unshift n
    end
    p move
    p zero_index
    puts
  end
  p buffer
  buffer[buffer.find_index(0)+1]
end

p calculate
