class SubscriptionOrder < ActiveRecord::Base
  belongs_to :issue
  belongs_to :subscription

  belongs_to :shoppe_order, :class_name => 'Shoppe::Order'
end
