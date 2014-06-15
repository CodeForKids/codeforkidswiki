# encoding: utf-8

class TinymceUploader < CarrierWave::Uploader::Base

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
