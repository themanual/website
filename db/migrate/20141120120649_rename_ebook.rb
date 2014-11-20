class RenameEbook < ActiveRecord::Migration
  def change
    Download.where(medium: 'eBook').update_all medium: 'Ebook'
  end
end
