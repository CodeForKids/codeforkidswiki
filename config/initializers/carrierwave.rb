CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
    :provider              => 'AWS',
    :aws_access_key_id     => ENV['S3_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET'],
    :region                => ENV['S3_REGION']
  }
  config.fog_directory  = ENV['S3_BUCKET_NAME']
  config.fog_public     = true                                    # optional, defaults to true
  config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}  # optional, defaults to {}

else
 #for development and testing locally
  config.storage = :file
  config.enable_processing = false
 end
end
