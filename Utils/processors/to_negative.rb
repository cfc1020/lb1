require_relative 'base'

module Utils
  module Processors
    class ToNegative < Base
      def run!
        histogramm = image.histogramm
        image.image_data = image.image_data.map do |r, g, b|
          r = 255 - r
          g = 255 - g
          b = 255 - b
          [r, g, b]
        end
      end
    end
  end
end
