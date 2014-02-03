class Piece < ActiveRecord::Base
	belongs_to :author
	belongs_to :issue

	validates_presence_of :body, :on => :create, :message => "is required"

	scope :ordered, -> { order('position ASC') }

	def issue_number
		@issue_number ||= issue.number
	end

	def author_slug
		@author_slug ||= author.slug
	end

	def random
		@random ||= Issue.public_issues.reject{|issue| issue.id == self.issue.id}.sample.articles.sample
	end

	def path
		if self.is_a? Article or self.is_a? Lesson
			Rails.application.routes.url_helpers.piece_path issue_number, author_slug, type.downcase
		end
	end

	def prev
		if self.is_a? Lesson

			return Article.where(issue_id: self.issue_id, author_id: self.author_id).first rescue nil

		elsif self.is_a? Article

			return Article.where(issue_id: self.issue_id)
										.where("position < #{self.position}")
										.order('position DESC')
										.limit(1)
										.first rescue nil
		end
	end

	def next

		if self.is_a? Article

			return Lesson.where(issue_id: self.issue_id, author_id: self.author_id).first rescue nil

		elsif self.is_a? Lesson

			return Article.where(issue_id: self.issue_id)
										.where("position > #{self.position}")
										.order('position ASC')
										.limit(1)
										.first rescue nil

		end
	end
end
