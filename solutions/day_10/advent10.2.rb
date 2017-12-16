#!/usr/bin/env ruby

require_relative "./advent10.1"

def lengths
  @lengths ||= STDIN.read.bytes + suffix
end

def suffix
  [17, 31, 73, 47, 23]
end

def rounds
  64
end

def sparse_hash
  @sparse_hash ||= (
    skip_size = skew = 0
    rounds.times do
      skip_size, skew = knot_hash(skip_size, skew)
    end
    reset_for_skew(skew)
  )
end

def dense_hash
  sparse_hash.each_slice(16).map do |chunk|
    chunk.reduce :^
  end
end

def hex_hash
  dense_hash.map{|i| i.to_s(16)}.join
end

if __FILE__ == $0
  puts hex_hash
end
