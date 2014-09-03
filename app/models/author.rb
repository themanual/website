class Author < ActiveRecord::Base
	has_many :articles
  after_save :touch_articles
	acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

  def touch_articles
    self.articles.each{|article| article.touch }
  end
end
