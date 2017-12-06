#!/usr/bin/env ruby

require_relative "./advent6.1"

def redistribute
  redistributions = 0
  memory          = mem
  seen            = nil

  while true do
    return redistributions if seen && seen == memory
    
    if history.include?(memory)
      seen = memory.dup
      @history = Set.new
      redistributions = 0
    end
    do_redistribute(memory)
    redistributions += 1
  end
  redistributions
end

if __FILE__ == $0
  p redistribute
end
