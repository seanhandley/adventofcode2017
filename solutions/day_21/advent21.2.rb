#!/usr/bin/env ruby

require_relative "./advent21.1"

if __FILE__ == $0
  18.times {|i| enhance }
  p image.flatten.select{|c| c == '#'}.count
end
