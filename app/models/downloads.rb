class Downloads < ActiveRecord::Base
  belongs_to :issue

  has_attached_file :file,
                    path: ':rails_env/:hash/:filename',
                    hash_data: ':class/:attachment/:id',
                    hash_secret: '946c06d271d21b2aaae972c3563e49b7508ab0888e47c0dd6f906a0af50d7ea117befd03f5d14f55d9c30145b4de11bab8a9a622e1fc28f77fa293b586260efe'

end
