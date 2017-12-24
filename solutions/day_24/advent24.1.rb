#!/usr/bin/env ruby

def components
  @components ||= STDIN.read.split("\n").map{|i| i.split("/").map(&:to_i)}
end

def sorted_components
  @sorted_components ||= (components - starting_components).sort_by do |x|
    x.reduce(:+)
  end
end

def starting_components
  @starting_components ||= components.select{|x| x.include? 0 }
end

def non_starting_components
  @non_starting_components ||= components - starting_components
end

trap "SIGINT" do
  p best_solution
  puts
end

def best_solution
  if @winners.any?
    winner = @winners.max_by{|x| x.flatten.reduce :+ }
    [winner.flatten.reduce(:+), @winners.count, @solutions, winner]
  else
    "No winners yet"
  end
end

def valid_solution(solution)
  c = 0
  solution.each_with_index.map do |e, i|
    if e[0] > c
      c = e[1]
      e.reverse
    else
      c = e[0]
      e
    end
  end.each_cons(2).all? do |x,y|
    x[1] == y[0]
  end
end

def solve
  @winners = []
  @solutions = 0
  loop do
    @solutions += 1
    solution = [non_starting_components.sample]
    prev = solution[0]
    loop do
      candidates = (components-solution)

      candidate  = candidates.select do |x|
        prev.any?{|y| x.include?(y)} &&
          (
            valid_solution(solution.dup << x) ||
            valid_solution(solution.dup.unshift(x))
          )
      end.sample

      if candidate
        if valid_solution(solution.dup << candidate)
          solution << candidate
        else
          solution.unshift candidate
        end
        prev = candidate
      else
        break
      end
    end
    starting_components.each do |start|
      if valid_solution(solution.dup << start)
        @winners << (solution << start)
        break 
      elsif valid_solution(solution.dup.unshift(start))
        @winners << solution.unshift(start)
        break
      end
    end
    @winners.uniq!
  end
end

solve
