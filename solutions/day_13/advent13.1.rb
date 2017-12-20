#!/usr/bin/env ruby

require 'pp'

def input
  @input ||= Hash[
    STDIN.read.split("\n").map do |line|
      line.split(":").map(&:strip).map(&:to_i)
    end
  ].freeze
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

@firewall ||= get_firewall.clone
@firewall_history = []

def move_scanners
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

if __FILE__ == $0
  p travel[1]
end
