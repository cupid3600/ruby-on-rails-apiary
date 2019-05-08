class FileUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{model.model_name.plural}/#{model.id}/#{mounted_as}"
  end
end
