class IssuesController < ApplicationController

	def index

	end

	def show
		@issue = params[:issue].to_i

		redirect_to issues_url if !ISSUES[:published_issues].include?(@issue)
	end

	def piece
		issue = params[:issue].to_i
		key 	= params[:key]
		type 	= params[:type]

		begin
			@piece = Piece.new issue, key, type
		rescue Piece::InvalidPiece
			redirect_to issues_url
		end
	end
end
