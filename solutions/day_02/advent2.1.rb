#!/usr/bin/env ruby

def input
  @input ||= STDIN.read.split("\n").map{|row| row.split("\t").map(&:to_i)}
end

def calculate_checksum
  input.map do |row|
    row.max - row.min
  end.reduce :+
end

if __FILE__ == $0
  p calculate_checksum
end
