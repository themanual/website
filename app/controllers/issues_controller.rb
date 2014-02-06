class IssuesController < ApplicationController

	def index

	end

	def show
		# TODO: Ensure only visible issues can be seen (public, or purchased by current user)
		@issue = Issue.where(number: params[:issue].to_i).first

		redirect_to issues_url unless @issue
	end

	def piece

		author = Author.fetch_by_uniq_key!(params[:key], :slug)

		@piece = Piece.includes(:author, :issue).where(issue_id: params[:issue].to_i, type: params['type'].titleize, author_id: author.id).first

		redirect_to issues_url unless @piece
	end
end
