Paperclip::Attachment.default_options[:storage] = :fog
Paperclip::Attachment.default_options[:fog_credentials] = {
  provider: "AWS",
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_ACCESS_SECRET'],
  # scheme: 'http' # upload to S3 over http, to avoid SSL Certificate mismatch
}
Paperclip::Attachment.default_options[:fog_directory] = ENV['AWS_BUCKET']
# Paperclip::Attachment.default_options[:fog_host] = "#{ENV['AWS_BUCKET']}"
Paperclip::Attachment.default_options[:fog_public] = false


# avoid the content spoofing issue
require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
