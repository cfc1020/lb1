module Utils
  class Image
    attr_reader :image, :view

    def initialize(path)
      @image = Magick::Image.read(path).first
      @view = @image.view(0, 0, width, height)
    end

    def pixel_count
      image.rows * image.columns
    end

    def width
      image.columns
    end

    def height
      image.rows
    end

    def original_image_data
      image.export_pixels(0, 0, image.columns, image.rows, "RGB").each_slice(3)
    end

    def image_data
      @image_data ||= original_image_data
    end

    def image_data=(image_data)
      @recache_out = true
      @image_data = image_data
    end

    def build_out_image
      return @out_image if @out_image && !@recache_out
      @out_image = Magick::Image.new(image.columns, image.rows)
      @out_image.import_pixels(0, 0, image.columns, image.rows, "RGB", image_data.flatten, Magick::QuantumPixel)
      @recache_out = false
      @out_image
    end

    def histogramm
      image_data.each.with_object(Hash.new(0)) do |(r, g, b), res|
        y = 0.3 * r + 0.59 * g + 0.11 * b
        res[y] += 1
      end.map do |k, v|
        [k, v / pixel_count.to_f]
      end.sort_by do |k, v|
        k
      end.to_h
    end

    def histogramm2 path
      @image = Magick::Image.read(path).first
      @image_data = nil
      image_data.each.with_object(Hash.new(0)) do |(r, g, b), res|
        y = 0.3 * r + 0.59 * g + 0.11 * b
        res[y] += 1
      end.map do |k, v|
        [k, v / pixel_count.to_f]
      end.sort_by do |k, v|
        k
      end.to_h
    end

    def save(path, flag)
      unless flag
        build_out_image.write(path)
      else
        image.write(path)
      end
    end

    def display
      build_out_image.display
    end
  end
end
