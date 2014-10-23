class Subscription < ActiveRecord::Base

  enum status: {
    active: 0,
    complete: 1,
    cancelled: 2
  }

	belongs_to :user

  has_many :ownerships


  def add_issue issue
    if self.active? and self.issues_remaining > 0
      if self.ownerships.create user_id: self.user_id, issue_id: issue.id, level: self.level
        self.decrement! :issues_remaining
        self.complete! if self.issues_remaining == 0
      end
    end
  end

  def self.add_issue issue
    self.active.each do |s|
      s.add_issue issue
    end
  end


end
