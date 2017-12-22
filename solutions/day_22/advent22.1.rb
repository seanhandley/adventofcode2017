#!/usr/bin/env ruby

def cluster
  @cluster ||= STDIN.read.split("\n").map(&:chars)
end

def print_cluster
  cluster.each do |c|
    puts c.join
  end
  puts
end

@directions = [:up,:right, :down, :left].cycle

@direction = @directions.next
@row = @col = (cluster.count / 2)
@infections = 0

def grow_cluster
  @cluster.each do |row|
    row.unshift "."
    row << "."
  end
  blank = Array.new(@cluster[0].count) { "." }
  @cluster.unshift blank.dup
  @cluster << blank.dup
  @row += 1
  @col += 1
end

def burst
  curr = cluster[@row][@col]
  infected = curr == "#"
  @direction = infected ? @directions.next : (2.times { @directions.next }; @directions.next)
  if infected
    cluster[@row][@col] = '.'
  else
    cluster[@row][@col] = '#'
    @infections += 1
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

trap "SIGINT" do
  puts @infections
  puts @cluster.count
end

if __FILE__ == $0
  10_000.times { burst }
  p @infections
end
