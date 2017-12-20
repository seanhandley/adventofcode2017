#!/usr/bin/env ruby

require 'pp'

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

def input
  @input ||= Hash[
    STDIN.read.split("\n").map do |line|
      line.split(":").map(&:strip).map(&:to_i)
    end
  ].freeze
  # {
  #   0 => 3,
  #   1 => 2,
  #   4 => 4,
  #   6 => 4
  # }
end

def get_firewall
  @get_firewall ||= Hash[
    (0..input.keys.last).map do |key|
      range = input[key]
      pos = range ? 0 : -1
      [key, {range: (range || 0), pos: pos, dir: :down}]
    end
  ]
end

def travel
  journey = @firewall.map do |index, info|
    caught = (info[:pos] == 0)
    res = caught ? (index * info[:range]) : 0
    move_scanners
    [caught, res]
  end
  if journey.all?{|e| e[0] == false }
    [false, 0]
  else
    [true, journey.map{|e| e[1]}.reduce(:+)]
  end
end

def move_scanners(dry = false)
  @firewall.each do |index, info|
    next if info[:range] == 0
    if info[:dir] == :down
      if (info[:range] - 1) == info[:pos]
        info[:dir] = :up
        info[:pos] -= 1
      else
        info[:pos] += 1
      end
    else
      if info[:pos] == 0
        info[:dir] = :down
        info[:pos] += 1
      else
        info[:pos] -= 1
      end
    end
  end
end

@t = 0

def evade_capture
  while true do
    @firewall = @last_state || deep_copy(get_firewall)
    return @t unless travel[0]
    move_scanners
    @last_state = deep_copy(@firewall)
    @t += 1
  end
end

trap "SIGINT" do
  puts @t
end

p evade_capture
