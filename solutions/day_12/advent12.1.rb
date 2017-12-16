#!/usr/bin/env ruby

require 'set'

def input
  @input ||= Hash[
    STDIN.read.split("\n").map do |line|
      id, rest = line.split("<->")
      [id.strip.to_i, rest.split(",").map(&:strip).map(&:to_i)]
    end
  ]
end

def find_group(n)
  seen = Set.new
  keys = [n]
  input.keys.each do
    candidates = []
    keys.each do |key|
      candidates = candidates + input[key]
      input[key].each do |val|
        seen << val
      end
    end
    keys = candidates.uniq
  end
  seen
end

if __FILE__ == $0
  p find_group(0).count
end
