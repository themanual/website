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


		redirect_to issues_url if !ISSUES[:published_issues].include?(issue)
		redirect_to issues_url if ISSUES[:issue][issue][key].nil?
		redirect_to issues_url if ISSUES[:issue][issue][key][type].nil?

		@fm = {
			issue: issue,
			key: key,
			type: type,
			metadata: ISSUES[:issue][issue][key]
		}

	end
end
