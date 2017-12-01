#!/usr/bin/env ruby

def input
  @input ||= STDIN.gets.chars.map(&:to_i)
end

def calculate_captcha(offset)
  pairs = input.each_with_index.map do |e, i|
    index = (i + offset) % input.length
    e == input[index] ? e : 0
  end
  pairs.reduce :+
end

if __FILE__ == $0
  puts calculate_captcha(1)
end
