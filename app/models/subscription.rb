class Subscription < ActiveRecord::Base

  enum status: {
    active: 0,
    complete: 1,
    cancelled: 2
  }

	belongs_to :user

  has_many :ownerships

  scope :including, -> (issue_number){ where('start_issue <= :num AND start_issue + issues_duration > :num', num: issue_number) }


  def description
    Ownership::LEVELS[self.level][:description]
  end

  def issues
    (0..self.issues_duration-1).collect{|n| n + self.start_issue}
  end

  def add_issue issue
    if self.active? and self.issues_remaining > 0
      ownership = self.ownerships.find_or_initialize_by(user_id: self.user_id, issue_id: issue.id, level: self.level)
      if ownership.new_record?
        ownership.save!
        self.decrement! :issues_remaining
        self.complete! if self.issues_remaining == 0
      end
    end
  end

  def self.add_issue issue
    self.active.including(issue.number).each do |s|
      s.add_issue issue
    end
  end


end
