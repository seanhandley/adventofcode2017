#!/usr/bin/env ruby

require_relative "./advent22.1"

def burst
  case cluster[@row][@col]
  when "#"
    @direction = @directions.next
    cluster[@row][@col] = 'F'
  when "."
    2.times { @directions.next }
    @direction = @directions.next
    cluster[@row][@col] = 'W'
  when "W"
    cluster[@row][@col] = '#'
    @infections += 1
  when "F"
    @directions.next
    @direction = @directions.next
    cluster[@row][@col] = '.'
  end

  case @direction
  when :up
    grow_cluster if @row == 0
    @row -= 1
  when :down
    grow_cluster if @row == @cluster.count-1
    @row += 1
  when :left
    grow_cluster if @col == 0
    @col -= 1
  when :right
    grow_cluster if @col == @cluster[0].count-1
    @col += 1
  end
end

10_000_000.times { burst }
p @infections
