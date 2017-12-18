#!/usr/bin/env ruby

def steps
  @steps ||= STDIN.read.to_i
end

def limit
  2017
end

def calculate
  buffer = [0]
  (1..limit).each do |n|
    move = steps % buffer.length
    buffer.rotate! move
    buffer.push n
  end
  buffer[0]
end

p calculate
