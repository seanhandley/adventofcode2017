#!/usr/bin/env ruby

require 'pp'

def input
  @input ||= STDIN.read.split("\n")
end

def tree
  @tree ||= {}
end

def parse_input
  input.each do |line|
    name_and_weight, children = line.split("->")
    name, weight  = name_and_weight.strip.split
    weight.gsub!(/[\(\)]/,"")
    weight = weight.to_i
    if children
      children = children.gsub(" ","").split(",")
      children = Hash[[children,children.map{|_| nil}].transpose]
    end
    tree[name] = {weight: weight, children: children}
  end
end

def redistribute(parent,subtree)
  for name in subtree.keys
    begin
      entry = subtree[name]
      next unless entry
      if entry[:children]
        entry[:children].each do |name, contents|
          if contents
            redistribute(subtree, contents)
          else
            entry[:children][name] = parent[name]
            parent.delete(name)
          end
        end
        redistribute(subtree, entry[:children])
      end
    rescue
      break
    end
  end
  tree.each do |k,v|
    unless v[:children]
      place_leaf(tree, k, v)
      tree.delete(k)
    end
  end
end

def place_leaf(subtree, k, v)
  subtree.each do |n,m|
    if m && m[:children] && m[:children][k]
      m[:children][k] = v
      break
    else
      place_leaf(m[:children], k, v) if m && m[:children]
    end
  end
end

parse_input
redistribute(tree, tree)
pp tree.keys
