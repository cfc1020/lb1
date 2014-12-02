require_relative 'base'
require 'pry'

module Utils
  module Processors
    class Areas < Base
      def self.run! image, bits
        l, labels = 1, Array.new(image.height){ Array.new(image.width, 0) }
        binding.pry
        image.height.times do |i|
          image.width.times do |j|
            fill bits, labels, i, j, l, image.height, image.width
            l += 1
          end
        end

        binding.pry
        labels
      end

      def self.fill bits, labels, x, y, l, h, w
        if labels[x][y].zero? && bits[x][y].nonzero?
          labels[x][y] = l

          fill(bits, labels, x - 1, y, l, h, w) if x > 0
          fill(bits, labels, x + 1, y, l, h, w) if x < h - 2
          fill(bits, labels, x, y - 1, l, h, w) if y > 0
          fill(bits, labels, x, y + 1, l, h, w) if y < w - 2
        end

      rescue SystemStackError => e
        nil
      end
    end
  end
end
