#!/usr/bin/env ruby

require_relative "./advent2.1"

def calculate_checksum
  input.flat_map do |row|
    row.combination(2).map{|x| x.sort }.select{|y,x| x % y == 0}.map{|y,x| x / y }
  end.reduce :+
end

p calculate_checksum
