#!/usr/bin/env ruby

require_relative "./advent4.1"

def calculate_valid_passphrases
  input.map{|i| i.map{|j| j.chars.sort.to_s }}.select{|i| i.uniq.count == i.count}.count
end

if __FILE__ == $0
  p calculate_valid_passphrases
end
