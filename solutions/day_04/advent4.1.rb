#!/usr/bin/env ruby

def input
  @input ||= STDIN.read.split("\n").map{|row| row.split}
end

def calculate_valid_passphrases
  input.select{|i| i.uniq.count == i.count}.count
end

if __FILE__ == $0
  p calculate_valid_passphrases
end
