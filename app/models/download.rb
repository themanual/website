class Download < ActiveRecord::Base
  belongs_to :issue


  has_attached_file :file,
                    path: ':rails_env/:hash/:filename',
                    hash_data: ':class/:attachment/:id',
                    hash_secret: '946c06d271d21b2aaae972c3563e49b7508ab0888e47c0dd6f906a0af50d7ea117befd03f5d14f55d9c30145b4de11bab8a9a622e1fc28f77fa293b586260efe',
                    fog_file: lambda { |attachment|
                      {
                        content_disposition: 'attachment;'
                      }
                    }

  do_not_validate_attachment_file_type :file

  MEDIUMS = [
    'Audiobook',
    'Ebook'
  ]

  def name
    "Issue ##{issue.number}, #{self.medium}, #{self.format}"
  end

  def url
    file.expiring_url(5.minutes) #.gsub('http://https://', 'https://')
  end

  def to_param
    "#{self.id}-#{self.file_file_name.parameterize}"
  end
end
