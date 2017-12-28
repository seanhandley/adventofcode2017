#!/usr/bin/env ruby

def puzzle_input
  @puzzle_input ||= STDIN.read
end

def suffix
  [17, 31, 73, 47, 23]
end

def rounds
  64
end

def list
  @list ||= (0..255).to_a
end

def knot_hash(input, skip_size = 0, skew = 0)
  (input+suffix).each do |length|
    sub_list = list.slice!(0, length)
    list.insert(0, *sub_list.reverse)
    offset = (length + skip_size) % list.size
    skew += offset
    list.rotate!(offset)
    skip_size += 1
  end
  [skip_size, skew]
end

def reset_for_skew(skew)
  list.rotate!(-skew % list.size)
end

def sparse_hash(input)
  skip_size = skew = 0
  rounds.times do
    skip_size, skew = knot_hash(input, skip_size, skew)
  end
  reset_for_skew(skew)
end

def dense_hash(input)
  sparse_hash(input).each_slice(16).map do |chunk|
    chunk.reduce :^
  end
end

def hex_hash(input)
  dense_hash(input).map{|i| i.to_s(16).rjust(2,"0")}.join
end

def padded_bin_hash(input)
  @list = (0..255).to_a
  hex_hash(input.bytes).chars.map do |char|
    char.to_i(16).to_s(2).rjust(4,"0")
  end
end

def grid
  @grid ||= (
    (0..127).map do |i|
      padded_bin_hash("#{puzzle_input}-#{i}").join.gsub("0"," ").gsub("1","#").chars
    end
  )
end

if __FILE__ == $0
  p grid.flatten.count{|c| c == "#"}
end
