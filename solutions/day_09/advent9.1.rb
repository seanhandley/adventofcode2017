#!/usr/bin/env ruby

def stream
  @stream ||= STDIN.read
end

def parse
  scores         = []
  in_garbage     = false
  nesting_level  = 0
  in_negation    = false
  garbage_chars  = 0
  stream.chars.each do |char|
    if in_garbage
      case char
      when "!"
        in_negation = !in_negation
      when ">"
        in_garbage = false unless in_negation
        in_negation = false
      else
        garbage_chars += 1 unless in_negation
        in_negation = false
      end    
    else
      case char
      when "{"
        nesting_level += 1
      when "}"
        scores << nesting_level
        nesting_level -= 1
      when "<"
        in_garbage = true
      end
    end
  end
  [scores.reduce(:+), garbage_chars]
end

if __FILE__ == $0
  p parse[0]
end
