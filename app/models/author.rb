class Author < ActiveRecord::Base
  has_many :pieces
  after_save :touch_pieces
  acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

  def touch_pieces
    self.pieces.each{|article| article.touch }
  end
end
