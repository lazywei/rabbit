require "rabbit/utils"
require "rabbit/image/base"

module Rabbit
  module ImageManipulable
    class GIMP < Base

      unshift_loader(self)

      GIMP_COMMANDS = %w(gimp)
      HEADER = "gimp xcf file"
      HEADER_SIZE = HEADER.size

      include SystemRunner

      class << self
        def match?(filename)
          File.open(filename) do |f|
            HEADER == f.read(HEADER_SIZE)
          end
        end
      end

      private
      def ensure_resize(w, h)
        @pixbuf = @original_pixbuf.scale(w, h)
      end

      def update_size
        png_file = Tempfile.new("rabbit-loader-gimp-png")
        png_path = png_file.path
        command = <<-EOC
(let ((image (car (gimp-file-load RUN-NONINTERACTIVE
                                  "#{@filename}" "#{@filename}"))))
  (gimp-image-merge-visible-layers image 0)
  (let ((drawable (car (gimp-image-get-active-drawable image))))
    (file-png-save-defaults RUN-NONINTERACTIVE image drawable
                            "#{png_path}" "#{png_path}"))
  (gimp-image-delete image))
EOC
        args = %w(-i --batch-interpreter plug_in_script_fu_eval -b)
        args << command
        args << "(gimp-quit TRUE)"
        if GIMP_COMMANDS.any? {|gimp| run(gimp, *args); File.exist?(png_path)}
          png_file.open
          png_file.binmode
          loader = load_by_pixbuf_loader(png_file.read)
          @original_pixbuf = loader.pixbuf
        else
          raise GIMPCanNotHandleError.new("gimp #{args.join(' ')}",
                                          GIMP_COMMANDS)
        end
      end
    end
  end
end