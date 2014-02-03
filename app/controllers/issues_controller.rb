class IssuesController < ApplicationController

	def index

	end

	def show
		# TODO: Ensure only visible issues can be seen (public, or purchased by current user)
		@issue = Issue.where(number: params[:issue].to_i).first

		redirect_to issues_url unless @issue
	end

	def piece

		@piece = Piece.joins(:author).includes(:author, :issue).where(issue_id: params[:issue].to_i, type: params['type'].titleize, 'authors.slug' => params[:key]).first

		redirect_to issues_url unless @piece
	end
end
