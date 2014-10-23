class AddAttachmentFileToDownloads < ActiveRecord::Migration
  def self.up
    change_table :downloads do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :downloads, :file
  end
end
