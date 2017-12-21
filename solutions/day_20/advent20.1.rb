#!/usr/bin/env ruby

def particles
  @particles ||= STDIN.read.split("\n").each_with_index.map{|p, i| parse_particle(p, i) }
end


def parse_particle(particle, i)
  particle.split(", ").map(&:strip)
                      .map{|i| i.split("=")[1] }
                      .map{|i| i.gsub(/[<>]/,"")
                                .split(",")
                                .map(&:to_i)
                          } << i
end

def tick
  particles.each do |particle|
    particle[1][0] += particle[2][0]
    particle[1][1] += particle[2][1]
    particle[1][2] += particle[2][2]

    particle[0][0] += particle[1][0]
    particle[0][1] += particle[1][1]
    particle[0][2] += particle[1][2]
  end
end

def manhattan(x,y,z)
  x.abs + y.abs + z.abs
end

def smallest_particle
  particles.each_with_index.map do |p, i|
    [i, manhattan(*p[0])]
  end.min_by{|d| d[1] }[0]
end

if __FILE__ == $0
  500.times { tick }
  p smallest_particle
end
