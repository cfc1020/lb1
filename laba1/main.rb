require 'RMagick'
require 'slop'

require_relative '../utils/image'
require_relative '../utils/histogramm_plotter'
require_relative '../utils/processors/to_negative'
require_relative '../utils/processors/to_median_filter'
require_relative '../utils/processors/to_harmonic_mean'

opts = Slop.parse(help: true) do
  banner "Usage: laba 1 [options]"

  on 'infile=', 'input file'
  on 'outfile=', 'output file'
  on 'negative', 'to negative'
  on 'median_filter', 'to median filter'
  on 'harmonic_mean', 'to harmonic mean'
  on 'size=', 'size for median filter', as: Integer, default: 3
end

image = Utils::Image.new(opts[:infile])

HistogrammPlotter.plot(image.histogramm, 'Before correction', 'out1.jpeg')
Utils::Processors::ToNegative.new(image).run! if opts[:negative]
Utils::Processors::ToMedianFilter.new(image).run! opts[:size] if opts[:median_filter]
Utils::Processors::ToHarmonicMean.new(image).run! if opts[:harmonic_mean]

image.save(opts[:outfile], true) if opts[:negative] || opts[:median_filter] || opts[:harmonic_mean]
# image.save(opts[:outfile], false) if opts[:harmonic_mean]

HistogrammPlotter.plot(image.histogramm2(opts[:outfile]), 'After correction', 'out2.jpeg')
