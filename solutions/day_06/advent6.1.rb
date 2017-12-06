#!/usr/bin/env ruby

require 'set'

def mem
  @mem ||= STDIN.read.split.map(&:to_i)
end

def history
  @history ||= Set.new
end

def size
  @size ||= mem.size
end

def redistribute
  redistributions = 0
  memory          = mem
  while true do
    if history.include?(memory)
      return redistributions
    else
      do_redistribute(memory)
      redistributions += 1
    end
  end
end

def do_redistribute(memory)
  history << memory.dup
  largest_bank = largest_bank(memory)
  val = memory[largest_bank]
  memory[largest_bank] = 0
  (1..val).each do |index|
    memory[(index + largest_bank) % size] += 1
  end
end

def largest_bank(memory)
  largest = 0
  memory.each_with_index do |bank, index|
    largest = index if bank > memory[largest]
  end
  largest
end

if __FILE__ == $0
  p redistribute
end
