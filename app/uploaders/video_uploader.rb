class VideoUploader < FileUploader
  include CarrierWave::Video
  include CarrierWave::MiniMagick
  include CarrierWave::Video::Thumbnailer

  version :thumb do
    process thumbnail: [{ format: 'png', quality: 1, size: 184, strip: false }]
    def full_filename(for_file)
      png_name(for_file, version_name)
    end
  end

  def png_name(for_file, version_name)
    %(#{version_name}_#{for_file.chomp(File.extname(for_file))}.png)
  end
end
