require_relative 'base'
require 'pry'

module Utils
  module Processors
    class Areas < Base
      def self.run! image, bits
        l, labels = 1, Array.new(image.height, Array.new(image.width, 0))

        image.height.times do |i|
          image.width.times do |j|
            l += 1

            fill bits, labels, j, i, l, image.height, image.width
          end
        end

        labels
      end

      def self.fill bits, labels, x, y, l, h, w
        if labels[x][y] == 0 && bits[x][y] == 1
          labels[x][y] = l
            
          fill(bits, labels, x - 1, y, l, h, w) if x > 0
          fill(bits, labels, x + 1, y, l, h, w) if x < w - 1
          fill(bits, labels, x, y - 1, l, h, w) if y > 0
          fill(bits, labels, x, y + 1, l, h, w) if y < h - 1
        end
      end
    end
  end
end
