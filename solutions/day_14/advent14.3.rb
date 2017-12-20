#!/usr/bin/env ruby

require_relative "./advent14.2"

def colorize(color_code, text)
  "\e[#{color_code}m#{text}\e[0m"
end

@codes = (31..36).cycle

def find_region(start, number)
  neighbours = [start]
  code       = @codes.next
  while(coords = neighbours.shift)
    row, col = coords
    grid[row][col] = colorize(code, '■') if grid[row][col] == "#"
    neighbours << [row, col-1] if col > 0   && grid[row][col-1] == "#"
    neighbours << [row, col+1] if col < 127 && grid[row][col+1] == "#"
    neighbours << [row-1, col] if row > 0   && grid[row-1][col] == "#"
    neighbours << [row+1, col] if row < 127 && grid[row+1][col] == "#"
  end
end

def print_grid
  grid.each do |row|
    puts row.join
  end
end

regions
print_grid
