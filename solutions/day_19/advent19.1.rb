#!/usr/bin/env ruby

def maze
  @maze ||= STDIN.read.split("\n").map(&:chars)
end

def neighbours(row, col)
  [
    [:right, maze[row][col+1]],
    [:left,  maze[row][col-1]],
    [:up,    maze[row-1][col]],
    [:down,  maze[row+1][col]]
  ]
end

def next_direction(current_direction, row, col)
  winner = nil
  if [:left, :right].include?(current_direction)
    winner = neighbours(row,col).select do |n|
      [:up, :down].include?(n[0])
    end.select do |c|
      c[1] == "|"
    end
  else
    winner = neighbours(row,col).select do |n|
      [:left, :right].include?(n[0])
    end.select do |c|
      c[1] == "-"
    end
  end
  winner.first[0]
end

def solve
  row = 0
  col = maze[0].find_index("|")
  direction = :down
  string = ""
  steps = 0
  loop do
    current_char = maze[row][col]
    case current_char
    when "|"
      # do nothing
    when "-"
      # do nothing
    when "+"
      direction = next_direction(direction, row, col)
    when " "
      return [string, steps]
    else
      string += current_char
    end

    case direction
    when :up
      row -= 1
    when :down
      row += 1
    when :left
      col -= 1
    when :right
      col += 1
    end
    steps += 1
  end
end

if __FILE__ == $0
  puts solve[0]
end
