#!/usr/bin/env ruby

def lengths
  @lengths ||= STDIN.read.split(",").map(&:to_i)
end

def list
  @list ||= (0..255).to_a
end

def knot_hash(skip_size = 0, skew = 0)
  lengths.each do |length|
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

def calculate
  _, skew = knot_hash
  reset_for_skew(skew)
  list[0] * list[1]
end

if __FILE__ == $0
  p calculate
end
