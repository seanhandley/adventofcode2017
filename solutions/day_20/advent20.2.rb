#!/usr/bin/env ruby

require_relative "./advent20.1"

def remove_collisions
  dups = particles.group_by{ |e| e[0] }
                  .select { |k, v| v.size > 1 }
                  .map{|d| d[1].map{|e| e[3]} }
                  .flatten
                  .uniq
  @particles.reject!{|p| dups.include?(p[3]) }
end

if __FILE__ == $0
  100.times { tick ; remove_collisions }
  p particles.count
end
