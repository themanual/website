Paperclip::Attachment.default_options[:storage] = :fog
Paperclip::Attachment.default_options[:fog_credentials] = {
  provider: "AWS",
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_ACCESS_SECRET']
}
Paperclip::Attachment.default_options[:fog_directory] = "enjoy.themanual.org"
Paperclip::Attachment.default_options[:fog_host] = "https://enjoy.themanual.org"
Paperclip::Attachment.default_options[:fog_public] = false
