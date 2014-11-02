require_relative 'base'

module Utils
  module Processors
    class ToHarmonicMean < Base
      def run! size = 3
        # histogramm = image.histogramm
        p size
        image.height.times do |i|
          image.width.times do |j|
            start_i = i - size / 2 > 0 ? i - size / 2 : 0
            start_j = j - size / size > 0 ? j - size / 2 : 0

            array_pixels = []

            start_i.upto(start_i + size - 1) do |ii|
              start_j.upto(start_j + size - 1) do |jj|
                array_pixels << [{get_gr(image.view[ii][jj].red,
                  image.view[ii][jj].green,
                  image.view[ii][jj].blue) => [image.view[ii][jj].red,
                    image.view[ii][jj].red, image.view[ii][jj].blue]}] if ii < image.height && jj < image.width
              end
            end

            array_pixels.sort_by! { |item| item.first[0] }

            result = array_pixels[array_pixels.length / 2]

            image.view[i][j].red = result[0].first[1][0]
            image.view[i][j].green = result[0].first[1][1]
            image.view[i][j].blue = result[0].first[1][2]

            # image.view[i][j].red = 255 - image.view[i][j].red
            # image.view[i][j].green = 255 - image.view[i][j].green
            # image.view[i][j].blue = 255 - image.view[i][j].red
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
