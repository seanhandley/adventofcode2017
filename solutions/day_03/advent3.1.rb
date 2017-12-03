#!/usr/bin/env ruby

require 'set'

def max_size
  @max_size ||= STDIN.read.to_i
end

def ordering
  @ordering ||= [:right, :up, :left, :down].cycle
end

def spiral_sequence
  @spiral_sequence ||= build_spiral_sequence(max_size)
end

def build_spiral_sequence(num)
  diff  = 1
  count = 0
  seq   = [1]
  num.times.each do |n|
    if count == 2
      diff += 1 
      count = 0
    end
    seq << seq[n] + diff
    count += 1
  end
  @size = diff / 2
  seq.to_set
end

def change_direction?(num)
  spiral_sequence.include?(num)
end

def spiral
  @spiral ||= build_spiral
end

def build_spiral
  direction = nil
  (1..max_size).each_with_object({}) do |num, spiral|
    direction = ordering.next if change_direction?(num)
    spiral[num] ||= direction
  end
end

def distance(x, y, orig)
  (x - orig).abs + (y - orig).abs
end

def size
  @size || max_size / 4
end

def calculate_distance
  x = y = original_coords = size / 2
  (1..max_size).each do |num|
    return distance(x, y, original_coords) if max_size == num
    case spiral[num]
    when :up
      y -= 1
    when :down
      y += 1
    when :left
      x -= 1
    when :right
      x += 1
    end
  end
end

if __FILE__ == $0
  p calculate_distance
end
