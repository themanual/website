class Subscription < ActiveRecord::Base

  enum status: {
    active: 0,
    complete: 1,
    cancelled: 2
  }

  belongs_to :user

  has_many :ownerships

  scope :has_shipping, -> { where(level: ["print", "full"]) }
  scope :with_issue, -> (issue_number){ where('start_issue <= :num AND start_issue + issues_duration > :num', num: issue_number) }

  def description
    Ownership::LEVELS[self.level][:description]
  end

  def issues
    (0..self.issues_duration-1).collect{|n| n + self.start_issue}
  end

  def issues_names
    (issues.size == 1 ? "issue" : "issues") + " " + issues.to_sentence
  end

  def add_issue issue, shipped = true
    if active? and issues_remaining > 0
      ownership = ownerships.find_or_initialize_by(user_id: self.user_id, issue_id: issue.id, level: self.level)
      if ownership.new_record?
        ownership.shipped = shipped
        ownership.save!
      elsif shipped and !ownership.shipped?
        decrement! :issues_remaining
        ownership.shipped!
      end

      self.close!

    end
  end

  def close!
    complete! if all_shipped?
  end

  def all_shipped?
    issues_remaining == 0 && ownerships.where(shipped: true).count == issues_duration
  end

  def self.add_issue issue, shipped = true
    self.active.with_issue(issue.number).each do |s|
      s.add_issue issue, shipped
    end
  end


end
