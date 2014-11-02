require_relative 'base'

module Utils
  module Processors
    class ToHarmonicMean < Base
      def run! size = 9
        image.image_data = image.image_data.map.with_index do |pixel, i|
          r = pixel[0]
          g = pixel[1]
          b = pixel[2]

          index = i - size / 2 >= 0 ? i - size / 2 : 0

          total = (index..(index + size)).inject do |acc, ii|  
            break if ii >= image.image_data.size
            acc \
              + 1.0 / get_gr(
                      image.image_data[ii][0],
                      image.image_data[ii][1],
                      image.image_data[ii][2]
                    )
          end

          count = index + size < image.image_data.size ?
            size : image.image_data.size - index

          total = count / total
          [total / 3, total / 3, total / 3]
        end
      end

      private

      def get_gr(r, g, b)
        0.3 * r + 0.59 * g + 0.11 * b
      end
    end
  end
end
