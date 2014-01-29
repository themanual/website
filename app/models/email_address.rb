class EmailAddress < ActiveRecord::Base
	belongs_to :user
	has_many :session_tokens

	after_commit :sync_primary


	def sync_primary
		if self.primary?
			EmailAddress.where(user_id: self.user_id).where.not(id: self.id).update_all(primary: false)
			self.user.update_attribute :email, self.email
		end
	end
end
