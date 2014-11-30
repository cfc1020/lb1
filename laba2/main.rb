require 'RMagick'
require 'slop'

require_relative '../utils/image'
require_relative '../utils/histogramm_plotter'
require_relative '../utils/processors/to_negative'
require_relative '../utils/processors/areas'
require_relative '../utils/processors/binaryzation'

opts = Slop.parse(help: true) do
  banner "Usage: laba 1 [options]"

  on 'infile=', 'input file'
  on 'outfile=', 'output file'
end

image = Utils::Image.new(opts[:infile])

bits = Utils::Processors::Binaryzation.run! image

areas = Utils::Processors::Areas.run! image, bits


