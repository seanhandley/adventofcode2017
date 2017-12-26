#!/usr/bin/env ruby

require 'prime'

# The code is counting non primes in steps of 17
# between the starting value b and the finishing
# value c.
#
# a = 1
# b = 108_100
# c = 125_100
# d = 0
# e = 0
# f = 0
# g = 0
# h = 0

# loop do 
#   f = 1
#   d = 2
#   while g != 0
#     e = 2
#     while g != 0
#       g = (d * e) - b
#       f = 0 unless g == 0
#       e += 1
#       g = e - b
#     end
#     d += 1
#     g = d - b
#   end
  
#   h += 1 unless f == 0
#   exit if b == c
#   b += 17
# end

p (108_100..125_100).step(17).reject(&:prime?).count


