require_relative 'base'

module Utils
  module Processors
    class ToHarmonicMean < Base
      def run! size = 9
        image.height.times do |i|
          image.width.times do |j|
            start_j = j - size / 2 > 0 ? j - size / 2 : 0

            total = (start_j..(start_j + size)).inject do |acc, jj|  
              break acc if jj >= image.width
              
              gr = get_gr(
                image.view[i][jj].red,
                image.view[i][jj].green,
                image.view[i][jj].blue
              )

              if gr != 0.0
                acc + 1.0 / gr
              else
                acc
              end
            end

            # if i % 100 == 0
              # puts (image.view[i][j].red)
              # puts image.view[i][j]
            # end

            count = start_j + size < image.width ?
              size : image.width - start_j

            total = count / total

            if total != Float::INFINITY && total > 1
              # puts "#{total} - #{(total / 3).to_i}"
              # puts image.view[i][j].red
              image.view[i][j].red = (total / 3).to_i
              # puts image.view[i][j].red
              image.view[i][j].green = (total / 3).to_i
              image.view[i][j].blue = (total / 3).to_i
            end
          end
        end

        # image.image.view = image.view

        image.view.sync

        image.image_data = image.image_data.map do |r, g, b|
          [r, g, b]
        end
      end

      private

      def get_gr(r, g, b)
        0.3 * r + 0.59 * g + 0.11 * b
      end
    end
  end
end
