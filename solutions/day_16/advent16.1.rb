#!/usr/bin/env ruby

def dance_moves
  @dance_moves ||= STDIN.read.split(",").map { |move| parse_move(move) }
end

def programs
  @programs ||= ("a".."p").to_a
end

def parse_move(move)
  rest = move.slice(1,move.length-1)
  case move[0]
  when "s"
    ["s", rest.to_i]
  when "x"
    a, b = rest.split("/").map(&:to_i)
    ["x", [a,b]]
  when "p"
    a, b = rest.split("/")
    ["p", [a,b]]
  end
end

def dance
  dance_moves.each do |move|
    case move[0]
    when "s"
      programs.rotate!(0 - move[1])
    when "x"
      temp = programs[move[1][0]]
      programs[move[1][0]] = programs[move[1][1]]
      programs[move[1][1]] = temp
    when "p"
      x = programs.find_index(move[1][0])
      y = programs.find_index(move[1][1])
      temp = programs[x]
      programs[x] = programs[y]
      programs[y] = temp
    end
  end
end

if __FILE__ == $0
  dance
  puts programs.join
end
