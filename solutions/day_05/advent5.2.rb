#!/usr/bin/env ruby

def program
  @program ||= (
    lines = STDIN.read.split("\n").map(&:to_i)
    Hash[[(0..lines.count-1).to_a, lines].transpose]
  )
end

def execute
  step = pos = 0
  len  = program.keys.length
  while(pos < len && pos >= 0)
    val = program[pos]
    program[pos] = program[pos] + (val >= 3 ? -1 : 1)
    pos += val
    step += 1
  end
  step
end

if __FILE__ == $0
  p execute
end
