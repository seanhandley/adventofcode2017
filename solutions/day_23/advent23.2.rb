#!/usr/bin/env ruby

require 'prime'

p (108_100..125_100).step(17).reject(&:prime?).count


