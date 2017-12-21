#!/usr/bin/env ruby

require 'curses'

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

@window = Curses::Window.new(0,0,0,0)

def print_maze
  status = maze.map do |row|
    row.join
  end.join("\n")
  @window.setpos(0,0)
  @window.addstr(status)
  @window.refresh
  sleep 0.001
end

def colorize(color_code, text)
  "\e[#{color_code}m#{text}\e[0m"
end

def solve
  row = 0
  col = maze[0].find_index("|")
  direction = :down
  string = ""
  steps = 0
  restore_char = nil
  restore_coords = nil
  loop do
    if restore_char
      x, y = restore_coords
      maze[x][y] = "."#restore_char
    end

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

    restore_char = current_char
    restore_coords = [row,col]
    maze[row][col] = "♞"
    print_maze

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
