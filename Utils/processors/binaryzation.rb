require_relative 'base'
require_relative '../image'
require 'pry'

module Utils
  module Processors
    class Binaryzation < Base
      def self.run!(image, brightness_threshold = QRange * 1.0 / 2)
        i = image.map do |r, g, b|
          Image.get_gr(r, g, b) > brightness_threshold ? 1 : 0
        end
        # binding.pry
      end
    end
  end
end

