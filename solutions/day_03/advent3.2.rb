#!/usr/bin/env ruby

require_relative "./advent3.1"

def grid
  @grid ||= []
end

def neighbours_total(x,y)
  [
    grid.dig(y-1,x-1),
    grid.dig(y+1,x+1),
    grid.dig(y-1,  x),
    grid.dig(y+1,  x),
    grid.dig(  y,x-1),
    grid.dig(  y,x+1),
    grid.dig(y-1,x+1),
    grid.dig(y+1,x-1)
  ].compact.reduce :+ 
end

def calculate
  x = y = original_coords = size / 2
  grid[y] ||= []
  grid[y][x] = 1
  (1..max_size).each do |num|
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
    total = neighbours_total(x, y) || 0
    return total if total > max_size
    grid[y] ||= []
    grid[y][x] = total
  end
end

if __FILE__ == $0
  p calculate
end
