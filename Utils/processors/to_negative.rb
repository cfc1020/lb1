require_relative 'base'

module Utils
  module Processors
    class ToNegative < Base
      def run!
=begin
        histogramm = image.histogramm
        image.image_data = image.image_data.map do |r, g, b|
          r = 255 - r
          g = 255 - g
          b = 255 - b
          [r, g, b]
        end
=end
#begin
        image.height.times do |i|
          image.width.times do |j|
            image.view[i][j].red = 255 - image.view[i][j].red
            image.view[i][j].green = 255 - image.view[i][j].green
            image.view[i][j].blue = 255 - image.view[i][j].blue
          end
        end

        image.view.sync

        image.image_data = image.image_data.map do |r, g, b|
          [r, g, b]
        end
#end
      end
    end
  end
end
