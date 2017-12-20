#!/usr/bin/env ruby

require_relative "./advent14.1"

def find_region(start, number)
  neighbours = [start]
  while(coords = neighbours.shift)
    row, col = coords
    grid[row][col] = number if grid[row][col] == "#"
    neighbours << [row, col-1] if col > 0   && grid[row][col-1] == "#"
    neighbours << [row, col+1] if col < 127 && grid[row][col+1] == "#"
    neighbours << [row-1, col] if row > 0   && grid[row-1][col] == "#"
    neighbours << [row+1, col] if row < 127 && grid[row+1][col] == "#"
  end
end

def regions
  row = col = region = 0

  while row < 128
    while col < 128
      if grid[row][col] == "#"
        region += 1
        find_region([row, col], region)
      end
      col += 1
    end
    row +=1
    col = 0
  end

  region
end

if __FILE__ == $0
  p regions
end
