require_relative 'base'
require 'pry'

module Utils
  module Processors
    class Medoids < Base
      def self.run! labels, core_count = 5
        cores = []
        core_count.times { |i| cores << { [0, x] => [] } }

        loop do
          
        end
      end

      def dist x1, y1, x2, y2
        Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)
      end      
    end
  end
end
