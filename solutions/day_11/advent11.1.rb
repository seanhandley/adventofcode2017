#!/usr/bin/env ruby

def child_path
  @child_path ||= STDIN.read.split(",").map &:to_sym
end

class Node
  attr_accessor :n,  :s,  :ne,
                :nw, :se, :sw
end

def nodes
  @nodes ||= {}
end

# nodes = { [0,0,0] => Node(n: [1,0,0], ...), ..., [1,0,0] => Node(s: [0,0,0], ...) }
#
#   \ n  /
# nw +--+ ne
#   /    \
# -+      +-
#   \    /
# sw +--+ se
#   / s  \
#
# [x, y, z]
#
# x - runs  n/s  with + being northerly     and - being southerly
# y - runs nw/se with + being northwesterly and - being southeasterly
# z - runs ne/sw with + being northeasterly and - being southwesterly

# def setup
#   x = y = z = 0
#   @nodes << Node.new
#   child_path.each_with_index do |direction, i|
#     a = (nodes[i]   ||= Node.new)
#     b = (nodes[i+1] ||= Node.new)
#     a.send(:"#{direction}=", i+1)         unless a.send(direction)
#     b.send(:"#{opposite(direction)}=", i) unless b.send(direction)
#   end
# end

# def opposite(direction)
#   {
#     n: :s,
#     s: :n,
#     ne: :sw,
#     nw: :se,
#     sw: :ne,
#     se: :nw
#   }[direction]
# end

# setup

# p child_path.reverse.take(3)
# p nodes.reverse.take(3)

def calculate
  x = y = z = 0
  child_path.each do |direction|
    case direction
    when :n
      x += 1
    when :s
      x -= 1
    when :ne
      z += 1
    when :nw
      y += 1
    when :se
      y -= 1
    when :sw
      z -= 1
    end
  end
  p [x,y,z]
  (x - orig).abs + (y - orig).abs
end

# 729 < z < 757

p calculate