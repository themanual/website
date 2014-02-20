class StubOutFutureIssues < ActiveRecord::Migration
  def change
  	Issue.create number: 4, published_on: Date.new(2014,4,10)
  	Issue.create number: 5, published_on: Date.new(2014,8,10)
  	Issue.create number: 6, published_on: Date.new(2014,12,10)
  end
end
