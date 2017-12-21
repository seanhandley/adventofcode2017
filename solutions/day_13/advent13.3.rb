#!/usr/bin/env ruby

def input
  # @input ||= STDIN.read.split("\n").map do |line|
  #   line.split(":").map(&:strip).map(&:to_i)
  # end
  @input ||= [[0,3],[1,2],[4,4],[6,4]]
  # {
  #   0 => 3,
  #   1 => 2,
  #   4 => 4,
  #   6 => 4
  # }
end

def get_firewall
  firewall = input.map do |key, range|
    [key, range, 0, :down]
  end
  (0..firewall.last[0]).each do |i|
    if firewall[i][0] != i
      firewall.insert(i, [i,0,-1,:down])
    end
  end
  firewall
end

def travel
  i = 0
  captures = []
  while i < @firewall.length
    # p @firewall
    _, _, pos, _ = @firewall[i]
    captures << true if pos == 0
    move_scanners
    i += 1
  end
  captures.any?
end

def move_scanners
  f = @firewall.map do |stage|
    index, range, pos, dir = *stage
    if range == 0
      stage
    else
      if dir == :down
        if (range - 1) == pos
          dir = :up
          pos -= 1
        else
          pos += 1
        end
      else
        if pos == 0
          dir = :down
          pos += 1
        else
          pos -= 1
        end
      end
      [index, range, pos, dir].clone
    end
  end
  @firewall = f.clone
end

@t = 0

def evade_capture
  while true do
    @firewall = @last_state || get_firewall.clone
    p @t
    return @t unless travel
    move_scanners
    @last_state = @firewall.clone
    p @last_state
    @t += 1
    exit if @t > 12
  end
end

trap "SIGINT" do
  puts @t
end

p evade_capture
