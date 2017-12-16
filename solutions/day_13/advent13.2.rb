#!/usr/bin/env ruby

require_relative "./advent13.1"

def reset
  @firewall     = nil
  @get_firewall = nil
end

@t = 0

def evade_capture
  while true do
    @t.times { move_scanners }
    return @t unless travel[0]
    @t += 1
    reset
  end
end

trap "SIGINT" do
  puts @t
end

p evade_capture
