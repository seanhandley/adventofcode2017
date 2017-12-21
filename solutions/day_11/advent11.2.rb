#!/usr/bin/env ruby

def child_path
  @child_path ||= STDIN.read.split(",").map &:to_sym
end

def manhattan(x, y, z)
  (x.abs + y.abs + z.abs) / 2
end

def calculate
  x = y = z = 0
  max = 0
  child_path.each do |direction|
    case direction
    when :n
      x += 1
      z -= 1
    when :s
      x -= 1
      z += 1
    when :ne
      x += 1
      y += 1
    when :nw
      z -= 1
      y -= 1
    when :se
      z += 1
      y += 1
    when :sw
      x -= 1
      y -= 1
    end
    max = [max, manhattan(x,y,z)].max
  end
  max
end

p calculate
